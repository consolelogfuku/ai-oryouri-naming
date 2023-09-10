class GenerateForm
  require 'tiny_segmenter' # 形態素解析
  require 'nkf' # カタカナをひらがなに変換
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend CarrierWave::Mount

  mount_uploader :dish_image, DishImageUploader

  attribute :name_1, :string
  attribute :name_2, :string
  attribute :name_3, :string
  attribute :cooking_methods, default: []
  attribute :seasoning_id, :integer
  attribute :texture_id, :integer
  attribute :category_id, :integer
  attribute :point, :string
  attribute :dish_image, :string

  validates :name_1, length: { maximum: 15 }
  validates :name_2, length: { maximum: 15 }
  validates :name_3, length: { maximum: 15 }
  validates :cooking_methods, presence: true
  validates :seasoning_id, presence: true
  validates :texture_id, presence: true
  validates :category_id, presence: true
  validates :point, length: { maximum: 20 }

  def save_dish(current_user)
    # 料理名生成時にログインしていなければ、ゲストユーザー設定をする
    # user.rbでcurrent_userを使用できるよう、引数を渡す
    user = User.setup_guest_if_not_logedin(current_user)

    begin
      # 一つでも失敗したら保存しない
      ActiveRecord::Base.transaction do
        @dish = user.dishes.new(dish_params)
        # 食材
        names = [name_1, name_2, name_3].select(&:present?) # フォームに入力されていない時、空白が送られるため空白を削除
        names.each do |name|
          ingredient = Ingredient.find_by(name:)
          unless ingredient # DBに保存されている食材でない場合、形態素解析をし、createする
            morphemes = morphological_analysis(name)
            ingredient = Ingredient.create(name:, morphemes:)
          end
          @dish.ingredients << ingredient
        end
        # 調理法
        cooking_methods.each do |cooking_method|
          @dish.cooking_methods << CookingMethod.find_by(name: cooking_method)
        end
        @dish.save! # 保存できない場合は、例外を発生させて全ての処理をロールバックさせる(例外を発生させないと、処理がロールバックされず、DBに保存されてしまう)
      end
    # 例外が発生しても、createメソッドに戻れるようrescueする
    rescue ActiveRecord::RecordInvalid, ActiveRecord::NotNullViolation # NotNull~は食材が全部空のとき出るエラー
      return @dish # 例外が発生した場合、@dishは不完全なものであるため、createメソッドのelse句が走る(例外が発生しなかった場合は、trueが返る)
    end

    @dish # 例外が発生しなかった場合、rescue節内の@dishにはtrueが代入されてしまうため、返り値を設定
  end

  private

  def dish_params
    { seasoning_id:, texture_id:, category_id:,
      point:, dish_image:, dish_image_cache: }
  end

  # 形態素解析(カンマ区切りの文字列にしてmorphemesカラムに格納)
  def morphological_analysis(name)
    name = NKF.nkf('--hiragana -w', name) # 前処理(カタカナがあった場合、ひらがなに変更する)
    ts = TinySegmenter.new
    ts.segment(name).join(',') # 形態素解析した結果をカンマ区切りの文字列として処理する
  end
end

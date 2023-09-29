class GenerateForm
  require 'tiny_segmenter' # 形態素解析
  require 'nkf' # カタカナをひらがなに変換
  include ActiveModel::Model # form_withやerrorsを使えるようになったり、バリデーションの設定ができる
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

  # カスタムバリデーション
  validate :check_ingredient_presence
  validate :check_cooking_method_presence

  # 以下は各モデルのバリデーションで処理する
  # validates :cooking_methods, presence: true
  # validates :seasoning_id, presence: true
  # validates :texture_id, presence: true
  # validates :category_id, presence: true
  # validates :point, length: { maximum: 20 }

  def save_dish(current_user, ip_address)

    # 一つでも失敗したら保存しない
    ActiveRecord::Base.transaction do
      
      # 料理名生成時にログインしていなければ、ゲストユーザー設定をする
      # user.rbでcurrent_userを使用できるよう、引数を渡す
      user = User.setup_guest_if_not_logedin(current_user)
      # userに紐づけた@dishを作成
      @dish = user.dishes.new(dish_params)
      # 食材を@dishに関連付ける
      associate_ingredients_to_dish
      # 調理法を@dishに関連づける
      associate_cooking_methods_to_dish

      # formObject(@generate_dish)と@dishにバリデーションを実行(valid?は、失敗したら@generate_formにエラーオブジェクトが追加される)
      if valid? && @dish.valid?
        # バリデーションが通ったらmodalを表示させる
        show_loading_modal(ip_address)
      else
        # valid?がfalseの場合、@dish.valid?が検証されないため、@dish.valid?をここで実行
        unless @dish.valid?
          # @dishのエラーメッセージを@generate_fromに追加してあげる(form_withで@generate_formを使用しているため)
          @dish.errors.full_messages.each do |error_message|
            errors.add(:base, error_message) # errorsは、self.errorsのこと
          end
        end
        # バリデーションに通らなかったら例外を発生させて、トランザクションを全てrollbackさせる
        raise ActiveRecord::Rollback
      end
      # バリデーションが全て通ったら、保存処理をする
      @dish.save
    end
    # @dishを返す
    @dish
  end

  private

  def dish_params
    { seasoning_id: seasoning_id, texture_id: texture_id, category_id: category_id,
      point: point, dish_image: dish_image, dish_image_cache: dish_image_cache}
  end

  # 食材が最低一つは入力されているか確認
  def check_ingredient_presence
    unless [name_1, name_2, name_3].any?(&:present?)
      errors.add(:base, '食材は一つ以上入力してください')
    end
  end

  # 調理法が最低一つは入力されているか確認
  def check_cooking_method_presence
    unless cooking_methods.any?(&:present?)
      errors.add(:base, '調理法は一つ以上選択してください')
    end
  end

  # 食材を@dishに関連づける
  def associate_ingredients_to_dish
    names = [name_1, name_2, name_3].select(&:present?) # フォームに入力されていない時、空白が送られるため空白を削除
    names.each do |name|
      ingredient = Ingredient.find_by(name: name)
      unless ingredient # DBに保存されていない食材のみ形態素解析をし、createする
        morphemes = morphological_analysis(name)
        ingredient = Ingredient.create(name: name, morphemes: morphemes)
      end
      @dish.ingredients << ingredient
    end
  end

  # 調理法を@dishに関連づける
  def associate_cooking_methods_to_dish
    cooking_methods.each do |cooking_method|
      @dish.cooking_methods << CookingMethod.find_by(name: cooking_method)
    end
  end

  # 考え中ですモーダルを表示
  def show_loading_modal(ip_address)
    ActionCable.server.broadcast( # modal表示するためのメッセージをコンシューマーに送信
      "loading_channel_#{ip_address}", { event: 'showLoadingModal' }
    )
  end

  # 形態素解析(カンマ区切りの文字列にしてmorphemesカラムに格納)
  def morphological_analysis(name)
    name = NKF.nkf('--hiragana -w', name) # 前処理(カタカナがあった場合、ひらがなに変更する)
    ts = TinySegmenter.new
    ts.segment(name).join(',') # 形態素解析した結果をカンマ区切りの文字列として処理する
  end
end

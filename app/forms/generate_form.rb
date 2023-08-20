class GenerateForm
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
        @dish.ingredient = Ingredient.create(ingredient_params)
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

  def ingredient_params
    { name_1:, name_2:, name_3: }
  end
end

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
  validates :cooking_method, presence: true
  validates :seasoning_id, presence: true
  validates :texture_id, presence: true
  validates :category_id, presence: true
  validates :point, length: { maximum: 20 }

  def setup_dish(current_user)
    # 料理名生成時に、ログインしていなければ、自動的にゲストユーザー設定をする(user.rb内でcurrent_userを使用できるよう、引数を渡す)
    user = User.setup_guest_if_not_logedin(current_user)

    # 一つでも失敗したら保存しない
    ActiveRecord::Base.transaction do
      @dish = user.dishes.new(dish_params)

      # 食材
      @dish.ingredient = Ingredient.create(ingredient_params)

      # 調理法
      cooking_methods.each do |cooking_method|
        @dish.cooking_methods << CookingMethod.find_by(name: cooking_method)
      end

      @dish
    end
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

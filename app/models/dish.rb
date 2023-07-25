class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  belongs_to :seasoning
  belongs_to :texture
  belongs_to :category
  has_many :dishes_cooking_methods, dependent: :destroy
  has_many :cooking_methods, through: :dishes_cooking_methods

  before_validation -> { self.uuid = SecureRandom.uuid }
  validates :uuid, presence: true
  validates :point, length: { maximum: 20 } # 20文字以内
  validates :state, presence: true
  enum state: { draft: 0, published: 1 }

  # 食材と調理法も一緒に保存
  def save_with_ingredients_and_cooking_methods(name_1:, name_2:, name_3:, cooking_methods_name:)
    ActiveRecord::Base.transaction do
      # 食材(同じ食材の組み合わせがあった場合は、その食材を取得する)
      self.ingredient = Ingredient.find_or_create_by(name_1: name_1, name_2: name_2, name_3: name_3)
      # 調理法
      cooking_methods_name.each do |cooking_method_name|
        self.cooking_methods << CookingMethod.find_by(name: cooking_method_name)
      end
      save!
    end
  end

end


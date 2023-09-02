class DishIngredient < ApplicationRecord
  belongs_to :dish
  belongs_to :ingredient

  validates :dish_id, uniqueness: {scopr: :ingredient_id}
end

class DishesCookingMethod < ApplicationRecord
  belongs_to :dish
  belongs_to :cooking_method

  validates :dish_id, uniqueness: {scope: :board_id}
end

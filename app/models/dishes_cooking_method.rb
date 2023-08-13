# frozen_string_literal: true

class DishesCookingMethod < ApplicationRecord
  belongs_to :dish
  belongs_to :cooking_method

  validates :dish_id, uniqueness: { scope: :cooking_method_id }
end

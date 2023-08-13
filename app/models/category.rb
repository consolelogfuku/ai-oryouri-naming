# frozen_string_literal: true

class Category < DishAttribute
  has_many :dishes
end

class Ingredient < ApplicationRecord
  has_many :dishes_ingredients, dependent: :destroy
  has_many :dishes, through: :dishes_ingredients

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :morphemes, presence: true, uniqueness: true
end
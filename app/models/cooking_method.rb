class CookingMethod < ApplicationRecord
  has_many :dishes_cooking_methods, dependent: :destroy
  has_many :dishes, through: :dishes_cookind_methods

  validates :name, presence: true, uniqueness: true
  validates :name_en, uniqueness: true
end

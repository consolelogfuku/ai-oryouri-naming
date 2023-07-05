class CookingMethod < ApplicationRecord
  has_many :dishes, through: :dishes_cookind_methods

  validates :name, presence: true, uniqueness: true
end

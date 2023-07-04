class CookingMethod < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end

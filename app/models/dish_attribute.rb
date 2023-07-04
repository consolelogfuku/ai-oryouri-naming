class DishAttribute < ApplicationRecord
  validates :name, presence: true
  validates :type, presence: true
end

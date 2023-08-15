class DishAttribute < ApplicationRecord
  validates :type, presence: true
  validates :name, presence: true
end

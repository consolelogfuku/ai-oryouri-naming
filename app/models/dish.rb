class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  belongs_to :seasoning
  belongs_to :texture
  belongs_to :category

  validates :uuid, presence: true
  validates :state, presence: true
  emun state: { draft: 0, published: 1 }
end

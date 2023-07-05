class Dish < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient
  belongs_to :seasoning
  belongs_to :texture
  belongs_to :category
  has_many :cooking_methods, through: :dishes_cooking_methods

  validates :uuid, presence: true
  validates :state, presence: true
  enum state: { draft: 0, published: 1 }
end

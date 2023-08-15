class Like < ApplicationRecord
  belongs_to :user
  belongs_to :dish

  validates :user_id, uniqueness: { scope: :dish_id }
end

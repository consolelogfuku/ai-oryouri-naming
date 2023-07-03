class User < ApplicationRecord
  has_many :dishes, dependent: :destroy

  before_create -> { self.uuid = SecureRandom.uuid }
  validates :name, presence: true
end

class User < ApplicationRecord
  has_many :dishes, dependent: :destroy

  before_create -> { self.uuid = SecureRandom.uuid }
  validates :name, presence: true, length: { maximum: 20 } # 20文字以内
end

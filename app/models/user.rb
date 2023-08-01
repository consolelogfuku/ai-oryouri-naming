class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :dishes, dependent: :destroy

  before_validation -> { self.uuid = SecureRandom.uuid }
  validates :uuid, presence: true
  validates :name, presence: true, length: { maximum: 20 } # 20文字以内
  validates :email, presence: true, uniqueness: true
  
end

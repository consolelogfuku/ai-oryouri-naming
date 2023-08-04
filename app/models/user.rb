class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :dishes, dependent: :destroy

  before_validation -> { self.uuid = SecureRandom.uuid }
  validates :uuid, presence: true
  validates :name, presence: true, length: { maximum: 20 } # 20文字以内
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # urlにuuidを使用
  def to_param
    uuid
  end
end

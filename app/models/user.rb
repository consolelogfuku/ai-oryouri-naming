class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  has_many :dishes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_dishes, through: :likes, source: :dish

  before_create -> { self.uuid = SecureRandom.uuid }
  validates :name, presence: true, length: { maximum: 15 } # 20文字以内
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  mount_uploader :avatar, AvatarUploader

  scope :set_guest, -> { where('name = ? AND created_at <= ?', ENV.fetch('USER_NAME', nil), 1.day.ago) }

  # urlにuuidを使用
  def to_param
    uuid
  end

  def self.setup_guest_if_not_logedin(current_user)
    if current_user.nil?
      User.new(
        name: ENV.fetch('USER_NAME', nil),
        email: "#{SecureRandom.alphanumeric(10)}@email.com",
        password: 'password',
        password_confirmation: 'password'
      )
    else
      current_user
    end
  end

  def own?(object)
    id == object.user_id
  end

  def like(dish)
    like_dishes << dish
  end

  def unlike(dish)
    like_dishes.destroy(dish)
  end

  def like?(dish)
    like_dishes.include?(dish)
  end
end

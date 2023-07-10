class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save :downcase_email
    
  validates :name, presence: true, length: {maximum: Settings.digit.length_60}
  validates :email, presence: true, length: {maximum: Settings.digit.length_60}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
    
  has_secure_password

  def User.digest string
    cost = ActiveModel::SecurePassword.mincost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

    BCrypt::Password.create string, cost: cost
  end

  private
  def downcase_email
    email.downcase!
  end
end

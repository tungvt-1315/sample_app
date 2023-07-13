# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z]+)*\.[a-z]+\z/i

  before_save :downcase_email

  validates :name, presence: true, length: {maximum: Settings.digit.length_60}
  validates :email, presence: true, length: {maximum: Settings.digit.length_60},
                    format: {with: VALID_EMAIL_REGEX}

  has_secure_password

  def self.digest string
    bcrypt_min_cost = BCrypt::Engine::MIN_COST
    bcrypt_cost = BCrypt::Engine.cost
    cost = ActiveModel::SecurePassword.mincost ? bcrypt_min_cost : bcrypt_cost

    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end
end

class User < ApplicationRecord
  has_secure_password validations: false

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, confirmation: false
end

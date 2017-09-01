class User < ApplicationRecord
  has_secure_password validations: false
  has_many :books
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, length: { minimum: 8 }, confirmation: false
end

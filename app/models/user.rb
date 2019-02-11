class User < ApplicationRecord
  include EmailValidation
  has_secure_password
  has_many :events

  # validates_uniqueness_of :email
  validates_presence_of :name, :email, :password, :password_confirmation
  validates :email, uniqueness: { case_sensitive: false}, format: { with: EmailValidation::REGEX }
end

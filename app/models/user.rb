class User < ApplicationRecord
  include EmailValidation
  has_secure_password

  # validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates :email, uniqueness: { case_sensitive: false}, format: { with: EmailValidation::REGEX }
end

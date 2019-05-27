class User < ApplicationRecord
  include EmailValidation
  has_secure_password
  has_many :events

  # validates_uniqueness_of :email
  validates_presence_of :name, :email, :password, :password_confirmation
  validates :email, uniqueness: { case_sensitive: false}, format: { with: EmailValidation::REGEX }

  def all_events
    events.order(created_at: :asc)
  end

  def upcoming_events(filter=nil)
    return all_events if filter.nil?

    events.where('start_time > ?', Time.now).order(created_at: :asc)
  end
end

class User < ApplicationRecord
  include Concerns::Docs::User
  include EmailValidation
  has_secure_password
  has_many :events
  has_many :centers

  # validates_uniqueness_of :email
  validates_presence_of :name, :email, :password, :password_confirmation
  validates :email, uniqueness: { case_sensitive: false}, format: { with: EmailValidation::REGEX }

  concerning :Events do
    def all_events
      events.order(created_at: :asc)
    end

    def upcoming_events(filter=nil)
      return all_events if filter.nil?

      events.where('start_time > ?', Time.now).order(created_at: :asc)
    end
  end

  concerning :Centers do
    def all_centers
      # .with_attached_image is a scope provided by ActiveStorage that helps reduce
      # N + 1 queries when fetching images
      centers.order_by_id.with_attached_image
    end
  end
end

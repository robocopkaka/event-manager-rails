class Center < ApplicationRecord
  include Concerns::Docs::Center

  belongs_to :user
  has_one :address, as: :addressable, dependent: :destroy

  validates_presence_of :name, :description, :capacity
  validates_uniqueness_of :name, scope: :address, case_sensitive: false, message: "has been taken in the location specified"
  has_one_attached :image
  has_many :events
  validates :image, blob: {
    content_type: %w[image/png image/jpg image/jpeg]
  }
  scope :order_by_id, -> { order(id: :asc) }

  def all_events
    events
      .includes([bookings: :user], :address, :center, :user)
      .order(created_at: :asc)
  end

  def upcoming_events
    events.where('start_time > ?', Time.now).order(created_at: :asc)
  end

  def past_events
    all_events.where('start_time < ?', Time.now).order(created_at: :asc)
  end

  def find_event!(id)
    events.find_by!(id: id)
  end
end

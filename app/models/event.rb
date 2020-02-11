class Event < ApplicationRecord
  include ActiveModel::Validations
  include Concerns::Docs::Event

  belongs_to :center, optional: true
  belongs_to :user

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  has_many :bookings
  has_many :attendees, through: :bookings, source: :user

  validates_presence_of :name, :description, :guests
  validates_uniqueness_of :name,
                          case_sensitive: false,
                          scope: :center_id,
                          message: "Name has already been taken in center",
                          unless: -> { center.nil? }
  validates :start_time, timeliness: { type: :datetime }
  validates :end_time, timeliness: { type: :datetime }
  validates_with DatesValidator

  scope :upcoming_events, -> { where("start_time > ?", Time.now).order(created_at: :asc) }
  scope :past_events, -> { where("start_time < ?", Time.now).order(created_at: :asc) }

  # overwrite address getter to use center's address if event doesn't have one
  def address
    super || center.address
  end
end
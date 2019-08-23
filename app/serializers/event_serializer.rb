class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :guests, :start_time, :end_time, :address

  # has_many :attendees, through: :bookings, source: :user
  has_many :bookings
  has_one :user
end
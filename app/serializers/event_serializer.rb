class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :guests, :start_time, :end_time, :address, :center_id

  # has_many :attendees, through: :bookings, source: :user
  has_many :bookings
  has_one :user

  def address
    return build_address(object.center.address) unless object.center_id.nil?

    build_address(object.address)
  end

  private

  # using this since ams default is :json and don't want to use
  # has_one :addressable
  def build_address(address)
    {
      id: address&.id,
      address_line1: address&.address_line1,
      address_line2: address&.address_line2,
      city: address&.city,
      state: address&.state,
      country: address&.country,
    }
  end

  def center_id
    object.center.id
  end
end
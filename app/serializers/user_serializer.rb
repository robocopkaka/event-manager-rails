class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bookings

  def bookings
    object.bookings.pluck(:id)
  end
end

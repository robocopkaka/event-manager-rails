class BookingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :event_id, :user

  def user
    object.user.id
  end
end

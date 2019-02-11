class EventSerializer < ActiveModel::Serializer
  attributes :name, :description, :guests, :start_time, :end_time
  belongs_to :center
  belongs_to :user
end
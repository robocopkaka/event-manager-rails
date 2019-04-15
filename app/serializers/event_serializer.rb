class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :guests, :start_time, :end_time
end
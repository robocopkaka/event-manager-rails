class EventSerializer < ActiveModel::Serializer
  attributes :name, :description, :guests, :datetime
  belongs_to :center
  belongs_to :user
end
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates_presence_of :address_line1, :city, :state, :country
end

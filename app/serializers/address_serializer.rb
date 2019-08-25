class AddressSerializer < ActiveModel::Serializer
  attributes :address_line1, :address_line2, :city,
             :state, :country
end
FactoryBot.define do
  factory :address do
    address_line1 { Faker::Address.building_number }
    address_line2 { Faker::Address.full_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
  end
end
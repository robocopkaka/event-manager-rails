# Center factory
FactoryBot.define do
  factory :center do
    name { Faker::Name.first_name }
    description { Faker::Lorem.paragraph(3) }
    capacity { Faker::Number.number(4) }
    user_id { create(:user).id }

    after(:create) do |center|
      center.address = create(:address, addressable: center)
    end
  end
end
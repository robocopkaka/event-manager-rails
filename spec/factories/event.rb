# Event factory
# As it is now, events can only be created if a center and user have already been created
# Center and User factories should have after_create hooks to create events
FactoryBot.define do
  factory :event do
    name { Faker::Name.first_name }
    guests { Faker::Number.number(4) }
    description { Faker::Lorem.paragraph(3) }
    datetime { DateTime.now }
    center_id { create(:user).id }
    user_id { create(:center).id }
  end
end
# Event factory
# As it is now, events can only be created if a center and user have already been created
# Center and User factories should have after_create hooks to create events
FactoryBot.define do
  factory :event do
    name { "#{Faker::Name.first_name} #{Faker::Name.last_name}" }
    guests { Faker::Number.number(4) }
    description { Faker::Lorem.paragraph(3) }
    # to avoid overlapping times use n^2 for start times
    sequence :start_time do |n|
      DateTime.now + (n*2).hours
    end
    sequence :end_time do
      start_time + 1.hour
    end
    center_id { create(:center).id }
    user_id { create(:user).id }

    trait :skip_validate do
      to_create {|instance| instance.save(validate: false)}
    end
  end
end

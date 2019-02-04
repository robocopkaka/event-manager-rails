# Event factory
# As it is now, events can only be created if a center and user have already been created
# Center and User factories should have after_create hooks to create events
FactoryBot.define do
  factory :event do
    name { Faker::Name.first_name }
    guests { Faker::Number.number(4) }
    description { Faker::Lorem.paragraph(3) }
    start_time { DateTime.now + 1.hour }
    end_time { DateTime.now + 3.hours }
    center_id { create(:center).id }
    user_id { create(:user).id }

    before(:create) do |event|
      unless Event.last.nil?
        event.start_time = Event.last.end_time + 1.hour
        event.end_time = event.start_time + 3.hours
      end
    end
  end
end
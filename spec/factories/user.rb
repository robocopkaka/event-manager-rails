# User factory

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { "#{Faker::Name.first_name}-#{Faker::Name.last_name}@events.com" }
    admin { false }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
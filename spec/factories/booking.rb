FactoryBot.define do
  factory :booking do
    event_id { create(:event).id }
    user_id { create(:user).id }
  end
end

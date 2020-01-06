require 'rails_helper'
RSpec.describe Event, type: :model do
  include CurrentUser
  let!(:new_user) { create :user }
  let!(:center) { create :center }

  describe 'validate presence of attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:guests) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:center).optional }
  end

  describe 'validates uniqueness' do
    let!(:event) { create :event, name: "kachi", center_id: center.id, user_id: new_user.id }

    it "should raise an error if the event name exists for the center" do
      event = FactoryBot.build(:event, name: "kachi", center_id: center.id, user_id: new_user.id)

      expect(event).to_not be_valid
      expect(event.errors.full_messages.to_sentence).to match "Name has already been taken in center"
    end
  end

  describe 'when an event has an invalid datetime format' do
    let(:event) { create :event, center_id: center.id, user_id: new_user.id }

    it 'should not be valid' do
      event.start_time = '2019-000-000'
      event.end_time = '2019-000-000'
      expect(event).to_not be_valid
    end
  end
end

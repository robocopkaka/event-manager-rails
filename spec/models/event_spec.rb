require 'rails_helper'
include CurrentUser
RSpec.describe Event, type: :model do
  let!(:user) { create :user }
  let!(:center) { create :center }
  before do
    CurrentUser.user = user # learn how to test mattr later
  end
  describe 'validate presence of attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:guests) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:center) }
  end

  describe 'validates uniqueness' do
    subject { FactoryBot.build :event, center_id: center.id, user_id: user.id }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'when an event has an invalid datetime format' do
    let(:event) { create :event, center_id: center.id, user_id: user.id }

    it 'should not be valid' do
      event.datetime = '2019-000-000'
      expect(event).to_not be_valid
    end

  end
end

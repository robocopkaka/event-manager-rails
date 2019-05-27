require 'rails_helper'

RSpec.describe EventService do
  let!(:user) { create :user }
  let!(:center) { create :center }
  let!(:user_events) { create_list :event, 5, user: user }
  let!(:center_events) { create_list :event, 5, center: center }


  describe "when user id is in params" do
    let!(:diff_events) { create_list :event, 5 }
    let(:user_params) { { user_id: user.id } }

    it "returns events for the user" do
      events = EventService.fetch_events(user_params)
      user_ids = events.pluck(:user_id).uniq

      expect(events.count).to be 5
      expect(user_ids.count).to eq 1
      expect(user_ids.first).to eq user.id
    end
  end

  describe "when center id is in params" do
    let(:center_params) { { center_id: center.id } }
    let!(:diff_events) { create_list :event, 5 }

    it "should return only events for the center" do
      events = EventService.fetch_events(center_params)
      center_ids = events.pluck(:center_id).uniq

      expect(events.count).to eq 5
      expect(center_ids.count).to eq 1
      expect(center_ids.first).to eq center.id
    end
  end

  describe "when nothing is passed in" do
    it "returns all the events in the database" do
      events = EventService.fetch_events

      expect(events.count).to eq 10
    end
  end

  describe "when an invalid value is passed in the params" do
    it "raises an error" do
      event = ActionController::Parameters.new("echo": "echo")
      events = EventService.fetch_events(event)

      expect(events).to eq []
    end
  end
end
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
    it "returns all the events" do
      params = ActionController::Parameters.new("echo": "echo")
      events = EventService.fetch_events(params)

      expect(events).to eq user_events + center_events
    end
  end

  describe "#create_event" do
    let!(:event_params) { attributes_for :event }
    let!(:address_params) { attributes_for :address }
    let(:event_service) {
      EventService.new(
        {
          event_params: event_params,
          address_params: address_params,
          center_id: center.id
        }
      )
    }

    context "when a center ID is passed" do
      it "creates an event belonging to a center" do
        event = event_service.create_event
        expect(Event.last). to eq event
        expect(center.address).to eq event.center.address
      end
    end

    context "when a center ID is not passed" do
      before do
        event_params.delete(:center_id)
      end
      let(:event_service) {
        EventService.new(
          {
            event_params: event_params,
            address_params: address_params,
          }
        )
      }
      it "creates an event not attached to a center" do
        event = event_service.create_event
        expect(Event.last).to eq event
        expect(address_params[:state]).to eq event.address.state
        expect(address_params[:country]).to eq event.address.country
        expect(address_params[:address_line1]).to eq event.address.address_line1
      end
    end
  end
end
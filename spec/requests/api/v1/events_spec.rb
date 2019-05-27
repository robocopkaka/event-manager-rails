# Events controller spec

require 'rails_helper'
RSpec.describe 'Events API' do
  include CurrentUser
  let!(:new_user) { create :user }
  let(:user_id) { new_user.id }
  let!(:center) { create :center }
  let(:center_id) { center.id }
  before do
    CurrentUser.user = new_user
  end

  describe 'POST api/v1/centers/:id/events' do
    let!(:params) {{ event: FactoryBot.attributes_for(:event) }}
    context 'when valid parameters are passed' do
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should return a 201' do
        expect(response).to have_http_status(201)
      end

      it 'should return an event object' do
        expect(json['data']['event']).to_not be_empty
        expect(json['data']['event']['name']).to match params[:event][:name]
        expect(json['data']['event']['guests']).to match params[:event][:guests].to_i
      end
    end

    context 'when posting to an invalid center_id' do
      let(:center_id) { 10000891 }
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should return a 404' do
        expect(response).to have_http_status(404)
      end
    end

    context 'when the start date overlaps with the end date for an existing event' do
      let!(:events) { create_list :event, 10, center_id: center_id }
      let(:params) do
        {
          event: FactoryBot.attributes_for(
            :event,
            center_id: center_id,
            start_time: events.first.end_time - 1.hour
          )
        }
      end
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should contain a 422' do
        expect(response).to have_http_status(422)
      end

      it 'should contain an error message' do
        message = 'Start time or end time overlaps with existing time'
        expect(json['message']).to match message
      end
    end

    context 'when the start time is in the past' do
      let(:params) do
        {
          event: FactoryBot.attributes_for(
                             :event,
                             start_time: DateTime.now - 1.hour,
                             center_id: center_id
          )
        }
      end
      before do
        post "/api/v1/centers/#{center_id}/events",
             params: params,
             headers: authenticated_headers(user_id)
      end

      it 'should return a 422 error code' do
        expect(response).to have_http_status(422)
      end

      it 'should have an error message' do
        expect(json['message']).to match 'Start time is in the past'
      end
    end
  end

  describe "#index" do
    describe "when center is in params" do
      before do
        travel_to Time.local(2018)
        create_list :event, 5, :skip_validate, center: center
        travel_back
        create_list :event, 5, :skip_validate, center: center
      end

      context "when no upcoming flag is set in the query" do
        before { get api_v1_center_events_path(center_id) }
        it "returns all the events" do
          returned_events = json["data"]["events"]
          expect(response).to have_http_status(200)
          expect(returned_events.count).to eq 10
          expect(returned_events.first["name"]).to eq Event.first.name
        end
      end

      context "when an upcoming flag is set" do
        before { get api_v1_center_events_path(center_id), params: { filter: "upcoming" } }
        it "returns only future events" do
          returned_events = json["data"]["events"]
          expect(response).to have_http_status(200)
          expect(returned_events.count).to eq 5
        end
      end

      # context "when the center has no events" do
      #   let!(:new_center) { create :center }
      #   before { get api_v1_center_events_path(new_center.id) }
      #
      #   it "should return an empty array" do
      #     expect(response).to have_http_status(200)
      #     expect(json["data"]["events"].count).to eq 0
      #   end
      # end
    end

    describe "when user is in params" do
      let!(:events) { create_list :event, 5, center: center, user: new_user }
      before { get api_v1_user_events_path(user_id) }
      context "when no upcoming flag is set in the query" do
        it "returns all the events" do
          returned_events = json["data"]["events"]
          expect(response).to have_http_status(200)
          expect(returned_events.count).to eq 5
          expect(returned_events.first["name"]).to eq Event.first.name
        end
      end

      context "when an upcoming flag is set" do
        before do
          travel_to Time.local(2018)
          create_list :event, 5, :skip_validate, center: center
          travel_back
          create_list :event, 5, :skip_validate, center: center
          get api_v1_user_events_path(user_id), params: { filter: "upcoming" }
        end
        it "returns only future events" do
          returned_events = json["data"]["events"]
          expect(response).to have_http_status(200)
          expect(returned_events.count).to eq 5
        end
      end

      context "when the user has no events" do
        let!(:different_user) { create :user }
        before { get api_v1_user_events_path(user_id: different_user.id) }

        it "should return an empty array" do
          expect(response).to have_http_status(200)
          # binding.pry
          expect(json["data"]["events"].count).to eq 0
        end
      end
    end
  end

  describe "#show" do
    let!(:event) { create :event, center: center }
    let(:event_id) { event.id }
    context "when a valid ID is passed" do
      before { get api_v1_event_path(id: event_id) }

      it "returns the actual event" do
        returned_event = json["data"]["event"]
        expect(response).to have_http_status(200)
        expect(returned_event["name"]).to eq Event.last.name
        expect(returned_event["guests"]).to eq Event.last.guests
      end
    end

    context "when an invalid event ID is passed" do
      before { get api_v1_event_path(id: 1000) }

      it "should return an error" do
        expect(response).to have_http_status(404)
        expect(json["message"]).to match "Couldn't find Event"
      end
    end
  end
end

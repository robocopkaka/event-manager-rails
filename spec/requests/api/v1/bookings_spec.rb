# frozen_string_literal: true

# Bookings request spec
require 'rails_helper'

RSpec.describe 'Bookings API' do
  let!(:user) { create :user }
  let!(:event) { create :event }
  let!(:bookings) { create_list :booking, 5, user_id: user.id }

  describe '#create' do
    context 'when reservation has not been made for an event' do
      before do
        post book_api_v1_event_path({ id: event.id }),
             headers: authenticated_headers(user.id)
      end
      it 'creates a reservation' do
        expect(response).to have_http_status 201
        expect(json['data']['booking']['user_id']).to eq user.id
        expect(json['data']['booking']['event_id']).to eq event.id
      end
    end

    context 'when the user has made a prior reservation at the same event' do
      before do
        2.times do
          post book_api_v1_event_path(id: event.id),
               headers: authenticated_headers(user.id)
        end
      end

      it 'returns an error' do
        expect(response).to have_http_status 422
        expect(json['message']).to include \
          "You've already made a reservation for this event"
      end
    end
  end

  describe '#destroy' do
    let(:event_id) { bookings.first.event_id }
    context 'when a valid is passed' do
      it 'deletes the booking' do
        expect do
          delete cancel_booking_api_v1_event_path(event_id), headers: authenticated_headers(user.id)
        end.to change{user.reservations.count}.by(-1)
      end
    end

    context 'when an invalid ID is passed' do
      before do
        delete cancel_booking_api_v1_event_path(10001), headers: authenticated_headers(user.id)
      end
      it 'returns an error' do
        expect(response).to have_http_status 404
        expect(json['message']).to eq 'Resource was not found'
      end
    end
  end

  describe '#reservations' do
    before do
      get reservations_api_v1_user_path(user.id), headers: authenticated_headers(user.id)
    end
    it 'returns the users reservations' do
      reservation_ids = json['data']['events'].pluck('id').to_set
      event_ids = Booking.where(user_id: user.id).pluck(:event_id).to_set
      expect(response).to have_http_status 200
      expect(event_ids).to eq reservation_ids
    end
  end

  describe '#attendees' do
    let!(:event_bookings) { create_list :booking, 5, event_id: event.id }
    before do
      get attendees_api_v1_event_path(event.id), headers: authenticated_headers(user.id)
    end
    it 'returns attendees for an events' do
      attendee_ids = json['data']['users'].pluck('id').to_set
      user_ids = Booking.where(event_id: event.id).pluck(:user_id).to_set
      expect(response).to have_http_status 200
      expect(user_ids).to eq attendee_ids
    end
  end
end

module Api::V1
  class BookingsController < ApplicationController
    before_action :authenticate_user, except: %i[attendees]
    def create
      current_user.reservations << Event.find_by!(id: params[:id])
      json_response(current_user.bookings.last, 'booking', 'Booking created successfully', :created)
    end

    def destroy
      booking = current_user.bookings.find_by!(event_id: params[:id]).destroy
      render json: booking
    end

    def reservations
      json_response(
        current_user.reservations,
        'reservations',
        'Reservations retrieved successfully'
      )
    end

    def attendees
      attendees = Event.find(params[:id]).attendees
      json_response(
        attendees,
        'attendees',
        'Attendees retrieved successfully',
      )
    end
  end
end

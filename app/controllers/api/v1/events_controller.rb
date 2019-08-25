module Api::V1
  class EventsController < ApplicationController
    include Api::V1::Concerns::Docs::EventsController
    before_action :authenticate_user, only: %i[create update book]
    before_action :find_event, only: %i[show update destroy]

    def create
      @event = EventService.new({
         event_params: event_params,
         address_params: address_params,
         center_id: params[:event][:center_id]
      }).create_event
      json_response(@event, 'event', 'Event was created successfully', :created)
    end

    def index
      @events = EventService.fetch_events(params)
      json_response(@events, 'events', 'Successfully retrieved events', :ok)
    end

    def show
      json_response(@event, 'event', 'Event retrieved successfully', :ok)
    end

    private

    def event_params
      params.require(:event).permit(
        :name, :guests, :image, :description, :start_time, :end_time
      ).merge!(user_id: current_user.id)
    end

    def address_params
      return nil if params[:address].nil?

      params.require(:address).permit(
        :address_line1, :address_line2, :city, :state, :country,
        :center_id
      )
    end

    def find_event
      @event = Event.includes(user: :bookings).find_by!(id: params[:id])
    end
  end
end
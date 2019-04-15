module Api::V1
  class EventsController < ApplicationController
    before_action :authenticate_user, only: %i[create update]
    before_action :find_center, only: %i[create update index show]
    before_action :find_event, only: %i[show update destroy]

    def create
      @event = @center.events.create!(event_params)
      json_response(@event, 'event', 'Event was created successfully', :created)
    end

    def index
      @events = @center.upcoming_events(params[:filter])
      json_response(@events, 'events', 'Successfully retrieved events', :ok)
    end

    def show
      json_response(@event, 'event', 'Event retrieved successfully', :ok)
    end

    private

    def event_params
      params.require(:event).permit(
        :name, :guests, :image, :description, :start_time, :end_time
      )
    end

    def find_center
      @center = Center.find_by!(id: params[:center_id])
    end

    def find_event
      @event = @center.find_event!(params[:id])
    end
  end
end
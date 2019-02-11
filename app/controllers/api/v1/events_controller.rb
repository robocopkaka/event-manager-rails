module Api::V1
  class EventsController < ApplicationController
    before_action :authenticate_user, only: %i[create update]
    before_action :find_center, only: %i[create update]

    def create
      @event = @center.events.create!(event_params)
      json_response(@event, 'event', 'Event was created successfully', :created)
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
  end
end
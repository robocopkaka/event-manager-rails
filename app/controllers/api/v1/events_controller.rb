module Api::V1
  class EventsController < ApplicationController
    require 'will_paginate/array'
    include Api::V1::Concerns::Docs::EventsController
    before_action :authenticate_user, only: %i[create update book]
    before_action :find_event, only: %i[show update destroy]
    before_action :set_attributes, only: :create

    def create
      @event = EventService.new({
         event_params: event_params,
      }).create_event

      json_response(@event, 'event', 'Event was created successfully', :created)
    end

    def index
      @events = EventService.fetch_events(params)
      paginate @events, per_page: params[:limit] || 9
    end

    def show
      json_response(@event, 'event', 'Event retrieved successfully', :ok)
    end

    private

    def event_params
      params.require(:event).permit(
        :name, :guests, :image, :description, :start_time, :end_time, :center_id,
        address_attributes: [:address_line1, :address_line2, :city, :state, :country]
      ).merge!(user_id: current_user.id)
    end

    def set_attributes
      return if params[:event][:center_id].present?

      params[:event][:address_attributes] = params[:event].delete(:address)
    end

    def find_event
      @event = Event.includes(user: :bookings).find_by!(id: params[:id])
    end
  end
end
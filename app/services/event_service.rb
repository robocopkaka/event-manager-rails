# frozen_string_literal: true

class EventService
  def initialize(params)
    @event_params = params[:event_params]
  end

  def create_event
    unless @event_params[:center_id].nil?
      return center.events.create!(@event_params)
    end
    Event.create!(@event_params)
  end
  class << self
    def fetch_events(params={})
      if params[:center_id].present?
        events = Center.find_by(id: params[:center_id]).upcoming_events
      elsif params[:user_id].present?
        events = User.find_by(id: params[:user_id]).upcoming_events
      else
        events = Event.upcoming_events
      end
      events
    end
  end

  private

  def center
    Center.find_by!(id: @event_params[:center_id])
  end
end

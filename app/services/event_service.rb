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
        Center.find_by(id: params[:center_id]).upcoming_events(params[:filter])
      elsif params[:user_id].present?
        User.find_by(id: params[:user_id]).upcoming_events(params[:filter])
      else
        Event.includes([bookings: :user], :address, :center, :user).all
      end
    end
  end

  private

  def center
    Center.find_by!(id: @event_params[:center_id])
  end
end
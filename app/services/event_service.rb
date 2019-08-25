class EventService
  def initialize(params)
    @event_params = params[:event_params]
    @address_params = params[:address_params]
    @center_id = params[:center_id]
  end

  def create_event
    unless @center_id.nil?
      return center.events.create!(@event_params)
    end
    event = Event.create!(@event_params)
    event.build_address(@address_params).save!
    event
  end
  class << self
    def fetch_events(params={})
      if params[:center_id].present?
        Center.find_by(id: params[:center_id]).upcoming_events(params[:filter])
      elsif params[:user_id].present?
        User.find_by(id: params[:user_id]).upcoming_events(params[:filter])
      else
        Event.all
      end
    end
  end

  private

  def center
    Center.find_by!(id: @center_id)
  end
end
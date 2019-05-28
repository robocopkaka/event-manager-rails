class EventService
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
end
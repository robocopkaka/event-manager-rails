class EventService
  class << self
    def fetch_events(params={})
      if params[:center_id].present?
        Center.find_by(id: params[:center_id]).upcoming_events(params[:filter])
      elsif params[:user_id].present?
        User.find_by(id: params[:user_id]).upcoming_events(params[:filter])
      else
        handle_extra(params)
      end
    end

    def handle_extra(params)
      #  handle a case where someone is passing in a wrong key/value pair
      return [] unless params.keys.count.zero?

      Event.all
    end
  end
end
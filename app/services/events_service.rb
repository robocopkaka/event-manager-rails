class EventsService
  def self.index(params)
    binding.pry
    center = Center.find_by!(id: params[:id])
    center.all_events
  end
end
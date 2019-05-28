class CenterService
  class << self
    def fetch_centers(params={})
      if params[:user_id].present?
        User.find_by!(id: params[:user_id]).all_centers
      else
        Center.order_by_id.with_attached_image
      end
    end
  end
end
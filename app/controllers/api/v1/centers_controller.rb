# frozen_string_literal: true
module Api::V1
  class CentersController < ApplicationController
    # before_action :authenticate_user, only: %i[create update]
    before_action :is_admin?, only: %i[create update]
    before_action :find_center, only: %i[update show]

    def create
      @center = Center.create!(center_params)
      json_response(@center, 'center', 'Center was successfully created', :created)
    end

    def update
      @center.update!(center_params)
    end

    def show
      json_response(@center, 'center', 'Center retrieved successfully')
    end

    def index
      # .with_attached_image is a scope provided by ActiveStorage that helps reduce
      # N + 1 queries when fetching images
      @centers = Center.order_by_id.with_attached_image
      json_response(@centers, 'centers', 'List of centers', :ok)
    end

    private

    def center_params
      params.require(:center).permit(:name, :description, :address, :capacity, :image)
    end

    private

    def is_admin?
      head :forbidden unless current_user.admin
    end

    def find_center
      @center = Center.find_by!(id: params[:id])
    end
  end
end
# Center controller

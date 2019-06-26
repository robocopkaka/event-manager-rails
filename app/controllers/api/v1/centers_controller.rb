# frozen_string_literal: true
module Api::V1
  class CentersController < ApplicationController
    include Api::V1::Concerns::Docs::CentersController

    before_action :authenticate_user, only: %i[create update]
    before_action :is_admin?, only: %i[create update]
    before_action :find_center, only: %i[update show]

    def create
      @center = current_user.centers.create!(center_params)
      json_response(@center, 'center', 'Center was successfully created', :created)
    end

    def update
      @center.update!(center_params)
      json_response(@center, 'center', 'Center was successfully updated', :ok)
    end

    def show
      json_response(@center, 'center', 'Center retrieved successfully')
    end

    def index
      @centers = CenterService.fetch_centers(params)
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

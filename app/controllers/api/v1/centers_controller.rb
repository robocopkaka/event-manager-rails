# frozen_string_literal: true
module Api::V1
  class CentersController < ApplicationController
    # before_action :authenticate_user, only: %i[create update]
    before_action :is_admin?, only: %i[create update]

    def create
      @center = Center.create!(center_params)
      @center.image.attach(params[:center][:image])
      json_response(@center, 'center', 'Center was successfully created', :created)
    end

    def update

    end

    def index
      @centers = Center.all
      json_response(@centers, 'centers', 'List of centers', :ok)
    end

    private

    def center_params
      params.require(:center).permit(:name, :description, :address, :capacity)
    end

    private

    def is_admin?
      head :forbidden unless current_user.admin
    end
  end
end
# Center controller

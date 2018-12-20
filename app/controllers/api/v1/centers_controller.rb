# frozen_string_literal: true
module Api::V1
  class CentersController < ApplicationController
    def create
      @center = Center.new(center_params)

      if @center.save
        json_response(@center, 'center', 'Center was successfully created', :created)
        # render json: @center, status: :created
      else
        json_response(@center.errors, 'errors', 'Operation had some errors', :unprocessable_entity)
        # render json: @center.errors, status: :unprocessable_entity
      end
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
  end
end
# Center controller

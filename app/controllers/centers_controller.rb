class CentersController < ApplicationController
  def create
    @center = Center.new(center_params)

    if @center.save
      render json: @center, status: :created
    else
      render json: @center.errors, status: :unprocessable_entity
    end
  end

  def index
    @centers = Center.all
    render json: @centers
  end

  private

  def center_params
    params.require(:center).permit(:name, :description, :address, :capacity)
  end
end

module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user, only: :show
    def create
      @user = User.new(user_params)
      if @user.save
        json_response(@user, 'user', 'User was successfully created', :created)
      else
        json_response(@user.errors, 'user', 'Your operation had some errors', :unprocessible_entity)
      end
    end

    def show
      json_response(current_user, 'user', 'User was retrieved successfully')
    end
    # def update
    #   if @user.update(user_params)
    #
    #   end
    # end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
end

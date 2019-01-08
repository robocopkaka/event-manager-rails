module Api::V1
  class UsersController < ApplicationController
    before_action :authenticate_user, only: :show
    def create
      @user = User.create!(user_params)
      json_response(@user, 'user', 'User was successfully created', :created)
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
      params.require(:user).permit(:name, :email, :password_digest, :password, :password_confirmation)
    end
  end
end

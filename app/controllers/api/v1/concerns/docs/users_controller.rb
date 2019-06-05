module Api::V1
  module Concerns::Docs
    module UsersController
      extend ActiveSupport::Concern

      included do
        include Swagger::Blocks

        swagger_path "/users" do

        end
      end
    end
  end
end
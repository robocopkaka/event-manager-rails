module Api::V1
  module Concerns::Docs
    module UsersController
      extend ActiveSupport::Concern

      included do
        include Swagger::Blocks

        swagger_path "/users" do
          operation :post  do
            key :summary, "Signup to the application"
            key :description, "Adds a new user to the database when they signup"
            key :operationId, "createUser"
            key :tags, ["user"]

            parameter do
              key :name, :user
              key :in, :body
              key :description, "User to be saved"
              key :required, true

              schema do
                key :'$ref', :User
              end
            end

            response 200 do
              key :description, "User signed up successfully"
              schema do
                key :'$ref', :ReturnedUser
              end
            end
            response 409 do
              key :description, "User already exists"
            end
            response 422 do
              key :description, "Malformed data sent in"
            end
            response 500 do
              key :description, "Internal server error"
            end
          end
        end

        swagger_path "/users/{id}" do
          operation :get do
            key :summary, "Fetch a user"
            key :description, "Fetch a user from the database using their id"
            key :operationId, "fetchUser"
            key :tags, ["user"]

            parameter do
              key :name, :id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end

            response 200 do
              key :description, "Users retrieved successfully"
              schema { key :'$ref', :ReturnedUser }
            end
            response 500 do
              key :description, "Internal server error"
            end

            security do
              key :api_key, []
            end
          end
        end

        swagger_path '/login' do
          operation :post do
            key :summary, 'Log in a user'
            key :description, 'Use details a user enters to log them in'
            key :operationId, 'loginUser'
            key :tags, ['user']

            parameter do
              key :name, :auth
              key :in, :body
              schema do
                key :'$ref', :Auth
              end
            end

            response 201 do
              key :description, 'Logged in successfully'
              schema { key :'$ref', :LoggedIn }
            end
            response 400 do
              key :description, 'Bad request'
            end
            response 404 do
              key :description, 'Resource was not found'
            end
            response 500 do
              key :description, 'Internal server error'
            end
          end
        end

        swagger_path  '/users/{user_id}/events' do
          operation :get do
            key :summary, "Fetch events belonging to a user"
            key :description, "Fetches events belonging to a user"
            key :operationId, "fetchUserEvents"
            key :tags, ["user"]

            parameter do
              key :name, :user_id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end

            response 200  do
              key :description, "Events retrieved successfully"
              schema do
                key :type, :array
                items do
                  key :'$ref', :ReturnedEvent
                end
              end
            end
            response 500 do
              key :description, "Internal server error"
            end
          end
        end

        swagger_path '/users/{user_id}/centers' do
          operation :get do
            key :summary, 'Fetch centers belonging to a user'
            key :description, 'Fetches centers belonging to a user'
            key :operationId, 'fetchUserCenters'
            key :tags, ['user']

            parameter do
              key :name, :user_id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end

            response 200  do
              key :description, "Centers retrieved successfully"
              schema do
                key :type, :array
                items do
                  key :'$ref', :ReturnedCenter
                end
              end
            end
            response 500 do
              key :description, "Internal server error"
            end
          end
        end
      end
    end
  end
end
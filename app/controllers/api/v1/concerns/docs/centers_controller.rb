module Api::V1
  module Concerns::Docs
    module CentersController
      extend ActiveSupport::Concern

      included do
        include Swagger::Blocks
        # parameter keys are defined in docs/docs_controller

        swagger_path "/centers" do
          operation :post do
            key :summary, "Add a center"
            key :description, "Adds a center"
            key :operationId, "addCenter"
            key :tags, ["center"]

            parameter :center_name
            parameter :center_description
            parameter :center_address
            parameter :center_capacity
            parameter :center_image

            response 201 do
              key :description, "Center created successfully"
              schema do
                key :'$ref', :ReturnedCenter
              end
            end
            response 401 do
              key :description, "User is unauthorized"
            end
            response 409 do
              key :description, "Center name already exists"
            end
            response 422 do
              key :description, "Malformed data was  sent in"
            end
            response 500 do
              key :description, "Internal server error"
            end

            security do
              key :api_key, []
            end
          end

          operation :get do
            key :summary, "Fetch centers"
            key :operationId, "fetchCenters"
            key :tags, ["center"]

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

        swagger_path "/centers/{id}" do
          operation :put do
            key :summary, "Edit a center"
            key :description, "Updates a center"
            key :operationId, "updateCenter"
            key :tags, ["center"]

            parameter do
              key :name, :id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end
            parameter :center_name
            parameter :center_description
            parameter :center_address
            parameter :center_capacity
            parameter :center_image

            response 200 do
              key :description, "Center was updated successfully"
              schema do
                key :'$ref', :ReturnedCenter
              end
            end
            response 401 do
              key :description, "User is unauthorized"
            end
            response 404 do
              key :description, "Center was not found"
            end
            response 409 do
              key :description, "Center name already exists"
            end
            response 422 do
              key :description, "Malformed data was  sent in"
            end
            response 500 do
              key :description, "Internal server error"
            end

            security do
              key :api_key, []
            end
          end

          operation :get do
            key :summary, "Fetch a center"
            key :description, "Fetch a center using its ID"
            key :operationId, "fetchCenter"
            key :tags, ["center"]

            parameter do
              key :name, :id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end

            response 200 do
              key :description, "Center was retrieved successfully"
              schema do
                key :'$ref', :ReturnedCenter
              end
            end
            response 404 do
              key :description, "Center was not found"
            end
            response 500 do
              key :description, "Internal server error"
            end
          end

          # Uncomment after delete action is added
          # operation :delete do
          #   key :summary, "Delete a center"
          #   key :description, "Delete a center using its ID"
          #   key :operationId, "deleteCenter"
          #   key :tags, ["center"]
          #
          #   parameter :id
          #   response 200 do
          #     key :description, "Center was deleted successfully"
          #     schema do
          #       key :'$ref', :ReturnedCenter
          #     end
          #   end
          #   response 404 do
          #     key :description, "Center was not found"
          #   end
          #   response 500 do
          #     key :description, "Internal server error"
          #   end
          # end
        end

        swagger_path "/centers/{center_id}/events" do
          operation :post do
            key :summary, "Create an event"
            key :description, "Create an event using a center's id"
            key :operationId, "createEvent"
            key :tags, ["event"]

            parameter do
              key :name, :center_id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int32
            end

            parameter do
              key :name, :event
              key :in, :body
              key :description, "Event to be saved"
              key :required, true
              schema do
                key :'$ref', :Event
              end
            end

            response 201 do
              key :description, "Event created successfully"
              schema do
                key :'$ref', :ReturnedEvent
              end
            end
            response 404 do
              key :description, "Center was not found"
            end
            response 409 do
              key :description, "Event name already exists"
            end
            response 422 do
              key :description, "An error occured"
            end

            security do
              key :api_key, []
            end
          end

          operation :get do
            key :summary, "Fetch events belonging to a center"
            key :description, "Fetches events belonging to a center"
            key :operationId, "fetchCenterEvents"
            key :tags, ["center"]

            parameter do
              key :name, :center_id
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
module Api::V1
  module Concerns::Docs
    module EventsController
      extend ActiveSupport::Concern

      included do
        include Swagger::Blocks

        swagger_path "/events" do
          operation :get do
            key :summary, "Retrieve all events"
            key :description, "Returns all events"
            key :operationId, "findAllEvents"
            key :tags, ["event"]

            response 200 do
              key :description, "events returned successfully"
              schema do
                key :'$ref', :ReturnedEvent
              end
            end
            response 422 do
              key :description, "An error occured"
            end
          end
        end

        swagger_path "/events/{id}" do
          operation :get do
            key :summary, "Fetch an event"
            key :description, "Returns an event"
            key :operationId, "findEvent"
            key :tags, ["event"]

            parameter :event_id

            response 200 do
              key :description, "event returned successfully"
              schema do
                key :'$ref', Event
              end
            end
          end

          operation :put do
            key :summary, "Update an event"
            key :description, "Updates an event"
            key :operationId, "updateEvent"
            key :tags, ["event"]

            parameter do
              key :name, :id
              key :in, :path
              key :required, true
              key :type, :integer
              key :format, :int64
            end
            parameter do
              key :name, :body
              key :in, :body
              key :description, "Event to be saved"
              key :required, true
              schema do
                key :'$ref', :Event
              end
            end

            response 200 do
              key :description, "event updated successfully"
              schema do
                key :'$ref', Event
              end
            end
            response 401 do
              key :description, "user is not authorized"
            end
            response 404 do
              key :description, "event was not found"
            end
            response 409 do
              key :description, "event name already exists/time overlaps"
            end
            response 422 do
              key :description, "an error occured"
            end

            security do
              key :api_key, []
            end
          end

          # Uncomment after adding delete action for events
          # operation :delete do
          #   key :summary, "Delete an event"
          #   key :description, "Deletes an event"
          #   key :operationId, "deleteEvent"
          #   key :tags, ["event"]
          #
          #   parameter do
          #     key :name, :id
          #     key :in, :path
          #     key :required, true
          #     key :type, :integer
          #     key :format, :int64
          #   end
          #
          #   response 200 do
          #     key :description, "event updated successfully"
          #     schema do
          #       key :'$ref', Event
          #     end
          #   end
          #   response 404 do
          #     key :description, "event was not found"
          #   end
          #   response 422 do
          #     key :description, "an error occured"
          #   end
          # end
        end
      end
    end
  end
end
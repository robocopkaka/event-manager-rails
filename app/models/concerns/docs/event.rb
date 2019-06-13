module Concerns::Docs
  module Event
    extend ActiveSupport::Concern

    included do
      include Swagger::Blocks

      swagger_schema :Event do
        key :required, [:name, :description, :guests]
        property :event do
          property :name do
            key :type, :string
          end
          property :description do
            key :type, :string
          end
          property :guests do
            key :type, :integer
            key :format, :int32
          end
          property :start_time do
            key :type, :string
            key :format, :date_time
          end
          property :end_time do
            key :type, :string
            key :format, :date_time
          end
        end
      end

      swagger_schema :ReturnedEvent do
        allOf do
          schema do
            key :'$ref', :Event
          end
          schema do
            key :required, [:id]
            property :event do
              property :id do
                key :type, :integer
                key :format, :int32
              end
            end
          end
        end
      end
    end
  end
end

module Concerns::Docs
  module Center
    extend ActiveSupport::Concern

    included do
      include Swagger::Blocks

      swagger_schema :ReturnedCenter do
        property :id do
          key :type, :integer
          key :format, :int32
        end
        property :name do
          key :type, :string
        end
        property :description do
          key :type, :string
        end
        property :address do
          key :type, :string
        end
        property :capacity do
          key :type, :integer
          key :format, :int32
        end
        property :user_id do
          key :type, :integer
          key :format, :int32
        end
        property :image do
          key :type, :string
          key :format, :binary
        end
      end
    end
  end
end
module Concerns::Docs
  module User
    extend ActiveSupport::Concern

    included do
      include Swagger::Blocks

      swagger_schema :User do
        key :required, [:name, :email, :password, :password_confirmation]
        property :user do
          property :name do
            key :type, :string
          end
          property :email do
            key :type, :string
          end
          property :password do
            key :type, :string
            key :format, :password
          end
          property :password_confirmation do
            key :type, :string
            key :format, :password
          end
        end
      end

      swagger_schema :ReturnedUser do
        property :user do
          property :id do
            key :type, :integer
            key :format, :int64
          end
          property :name do
            key :type, :string
          end
          property :email do
            key :type, :string
          end
        end
      end

      swagger_schema :Auth do
        property :auth  do
          property :email do
            key :type, :string
          end
          property :password do
            key :type, :string
            key :format, :password
          end
        end
      end

      swagger_schema :LoggedIn do
        property :jwt do
          key :type, :string
        end
      end
    end
  end
end
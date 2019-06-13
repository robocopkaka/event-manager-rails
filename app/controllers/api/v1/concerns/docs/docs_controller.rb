module Api
  module V1
    module Concerns
      module Docs
        module DocsController
          extend ActiveSupport::Concern

          included do
            include Swagger::Blocks

            swagger_root do
              key :swagger, '2.0'
              info do
                key :version, '2.0.0'
                key :title, 'Events API'
                key :description, 'Events API'
                contact do
                  key :name, 'robocopkaka@gmail.com'
                end
                license do
                  key :name, 'MIT'
                end
              end
              tag do
                key :name, 'event'
                key :description, 'Events Manager'
                # externalDocs do
                #   key :description, 'Find more info here'
                #   key :url, 'https://swagger.io'
                # end
              end
              key :schemes, ['https', 'http']
              key :host, 'localhost:3001'
              # key :host, 'shielded-citadel-82961.herokuapp.com'
              key :basePath, '/api/v1'
              key :consumes, ['application/json', 'application/x-www-form-urlencoded']
              key :produces, ['application/json']

              parameter :center_name do
                key :in, :formData
                key :name, :'center[name]'
                key :type, :string
              end
              parameter :center_description do
                key :in, :formData
                key :name, :'center[description]'
                key :type, :string
              end
              parameter :center_address do
                key :in, :formData
                key :name, :'center[address]'
                key :type, :string
              end
              parameter :center_capacity do
                key :in, :formData
                key :name, :'center[capacity]'
                key :type, :integer
                key :format, :int32
              end
              parameter :center_image do
                key :in, :formData
                key :name, :'center[image]'
                key :type, :file
              end
              parameter :id do
                key :name, :id
                key :in, :path
                key :required, true
                key :type, :integer
                key :format, :int32
              end

              security_definition :api_key do
                key :type, :apiKey
                key :name, :authorization
                key :in, :header
              end
            end

            SWAGGERED_CLASSES =  [
              Api::V1::EventsController,
              Api::V1::CentersController,
              Api::V1::UsersController,
              Center,
              Event,
              User,
              self
            ].freeze

            def index
              result = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
              render json: result
            end
          end
        end
      end
    end
  end
end
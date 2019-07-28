module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(:unprocessable_entity, 422, e.to_s )
        end
        rescue_from ActiveRecord::RecordNotUnique do |e|
          respond(:conflict, 409, e.to_s )
        end
        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:not_found, 404, "Resource was not found" )
        end
        rescue_from ActiveSupport::MessageVerifier::InvalidSignature do |e|
          respond(:unprocessable_entity, 422, 'Invalid image file')
        end
      end
    end

    private

    def respond(_error, _status, _message)
      json = Helpers::Render.json(_error, _status, _message)
      render json: json, status: _status
    end
  end
end
module Response
  def json_response(object, key, message, status=:ok)
    # Serialize user object before rendering it
    # Not doing this will render the entire user object
    object = ActiveModelSerializers::SerializableResource.new(object).as_json
    response = {
      message: message,
      data: {
        "#{key}": object
      }
    }
    render json: response, status: status
  end
end
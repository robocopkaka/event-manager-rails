module Response
  def json_response(object, key, message, status=:ok)
    response = {
      status: status,
      message: message,
      data: {
        "#{key}": object
      }
    }
    render json: response
  end
end
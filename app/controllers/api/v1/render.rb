private

def render_success(message, data)
  render json: {
    status: 'SUCCESS',
    message: message,
    data: data
  }, status: :ok
end

def render_failure(message, data)
  render json: {
    status: 'ERROR',
    message: message,
    data: data.errors
  }, status: :unprocessable_entity
end
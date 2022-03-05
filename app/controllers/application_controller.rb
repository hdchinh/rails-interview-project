class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # Can implement sentry here to make better debug
  rescue_from StandardError do
    failure_response(status: :internal_server_error, message: "Something went wrong.")
  end

  rescue_from ActiveRecord::RecordNotFound do
    failure_response(status: :not_found, message: "The resource does not exist.")
  end

  rescue_from ActionController::ParameterMissing do
    failure_response(message: "Param is missing or the value is empty.")
  end

  private

  def failure_response(message: "", status: :bad_request)
    render json: { message: message }, status: status
  end
end

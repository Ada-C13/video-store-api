class ApplicationController < ActionController::API

  #using error handling pattern from https://blog.rebased.pl/2016/11/07/api-error-handling.html
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { errors: ['Not Found'] } , status: :not_found
  end
end

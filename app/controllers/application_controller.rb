class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request

  private

    def record_not_found(error)
      render json: { error: error.message }, status: :not_found
    end

    def bad_request(error)
      render json: { error: error.message }, status: :bad_request
    end
end

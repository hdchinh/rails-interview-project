module API
  class BaseController < ApplicationController
    before_action :authenticate_request!

    private

    def authenticate_request!
      @tenant = Tenant.find_by(api_key: request.headers["api-key"])

      unless @tenant
        return failure_response(message: "api-key is invalid.", status: :unauthorized)
      end

      # Can use a background job to make better response time
      Tenant.increment_counter(:access_count, @tenant.id, touch: true)
    end

    def init_page_and_per_page
      @page = params[:page].to_i.zero? ? QuestionConstants::DEFAULT_PAGE : params[:page].to_i
      @per_page = params[:per_page].to_i.zero? ? QuestionConstants::DEFAULT_PER_PAGE : params[:per_page].to_i
    end
  end
end

class ApplicationController < ActionController::API
    def render_json_ok(resource)
        render json: {status: 'success', message: 'loaded successfully', data: resource}, status: :ok
    end

    def render_json_created(resource)
        render json: {status: 'success', message: 'created successfully', data: resource}, status: :created
    end

    def render_json_no_content(resource)
        render json: {status: 'success', data: resource}, status: :no_content
    end

    def render_json_bad_request(errors)
        render json: {status: 'failed', message: 'invalid data', errors: errors}, status: :bad_request
    end

    def render_json_not_found()
        render json: {status: 'failed', message: 'not found'}, status: :not_found
    end
end

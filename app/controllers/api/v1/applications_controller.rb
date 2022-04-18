class Api::V1::ApplicationsController < ApplicationController
  
  def index
    applications = Application.order('created_at DESC');
    render_json_ok(applications)
  end

  def show
    application = Application.find_by(token: params[:token])
    
    if application.present?
      render_json_ok(application)
    else
      render_json_not_found()
    end
  end

  def create
    application = Application.new(application_params)

    if application.save
      render_json_created(application)
    else
      render_json_bad_request(application.errors)
    end
  end

  def destroy
    application = Application.find_by(token: params[:token])
    
    if application.present?
      application.destroy
      render_json_no_content(application)
    else
      render_json_not_found()
    end
  end

  def update
    application = Application.find_by(token: params[:token])

    if application.present?
      if application.update(application_params)
        render_json_no_content(application)
      else
        render_json_bad_request()
      end
    else
      render_json_not_found()
    end
  end

  private

  def application_params
    params.permit(:name)
  end


end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_filter :get_slogan

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to main_app.root_url, alert: exception.message
    else
      session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
      redirect_to main_app.new_user_session_path
    end
  end

  private

  def get_slogan
    @slogan = Slogan.random
  end

  private

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def record_not_found
    redirect_to main_app.root_url, alert: "Page not found"
  end

end

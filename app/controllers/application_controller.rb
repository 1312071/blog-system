class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_authenticate

  include SessionsHelper

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t ".log_in"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".user_invalid"
      redirect_to users_url
    end
  end

  def basic_authenticate
    return unless ENV["BA_USER_NAME"] && ENV["BA_PASSWORD"]

    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == ENV["BA_USER_NAME"] && password == ENV["BA_PASSWORD"]
    end
  end
end

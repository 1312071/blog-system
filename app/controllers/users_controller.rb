class UsersController < ApplicationController

  def index
    @users = User.select(:id, :name, :email).order(name: :asc)
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
    if session[:errors] && session[:errors] == 0
      session[:errors] = nil
    else
      session[:errors] = 1
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".account_actived"
      session[:signuperrors] = {}
      redirect_to root_url
    else
      session[:signuperrors] = @user.errors.full_messages
      session[:errors] = 0
      redirect_to signup_url
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end

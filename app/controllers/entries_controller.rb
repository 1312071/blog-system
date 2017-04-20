class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :new, :destroy]
  before_action :load_entry, only: [:destroy, :owner?]

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build entry_params
    if @entry.save
      flash[:success] = t ".entry_created"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    if @entry.destroy
      flash[:success] = t ".entry_deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to root_url
  end

  private
  def entry_params
    params.require(:entry).permit :title, :description, :content, :picture
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t ".log_in"
      redirect_to login_url
    end
  end

  def load_entry
    @entry = Entry.find_by id: params[:id]
  end
end

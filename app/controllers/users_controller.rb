class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def index
    @users = User.by_query(params[:q]).page(params[:page]).per(params[:page_limit])
    render json: @users, callback: params[:callback]
  end

end

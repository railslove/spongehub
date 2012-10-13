class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def index
    @users = User.by_query(params[:q]).page(params[:page]).per(params[:page_limit])
    render json: @users, callback: params[:callback]
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

end

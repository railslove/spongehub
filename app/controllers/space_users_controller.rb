class SpaceUsersController < ApplicationController

  before_filter :authentication_required
  before_filter :load_and_ensure_space
  before_filter :check_space_membership

  def index
    @users = @space.users

    respond_to do |format|
      format.html # render view
      format.json do
        @users = @users.by_query(params[:q]).page(params[:page]).per(params[:page_limit])
        render json: @users, callback: params[:callback]
      end
    end
  end

  def create
    @user = User.find(params[:user_id])
    @space.users << @user
    # @space.user_ids = (@space.user_ids + [params[:user_id]].flatten.map(&:to_i)).uniq
    UserMailer.invite(@user, @space).deliver if @user.email.present?
    redirect_to [@space, :users], notice: 'User has been added to this space!'
  end

  def destroy
    if @space.user_ids.size > 1
      @space.user_ids = (@space.user_ids - [params[:id].to_i])
      redirect_to [@space, :users], notice: 'User has been removed from this space!'
    else
      redirect_to [@space, :users], alert: 'At least one user has to remain in a space!'
    end
  end

end
class SpaceUsersController < ApplicationController

  before_filter :load_and_ensure_space

  def index
    @users = @space.users
  end

  def create
    @space.user_ids = (@space.user_ids +  [params[:user_id]].flatten.map(&:to_i)).uniq
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
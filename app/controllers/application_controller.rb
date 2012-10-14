class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def load_and_ensure_space
    @space = Space.find(params[:space_id])
  rescue ActiveRecord::RecordNotFound => ex
    redirect_to :root, alert: 'The space you are looking for does not exist!'
  end

  def authentication_required
    redirect_to :root, alert: "Oh, oh! You don't wanna go there!" unless current_user
  end

  def check_space_membership
    if current_user.blank? || !@space.member?(current_user)
      redirect_to(@space, alert: "Oh, oh! What are you trying to do?!") and return
    end
  end

end

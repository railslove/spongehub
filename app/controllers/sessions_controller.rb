class SessionsController < ApplicationController

  def create
    authentication = Authentication.find_or_create_from_hash(env["omniauth.auth"])
    session[:user_id] = authentication.user.id
    redirect_to "/", notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/", notice: "Signed out!"
  end

end
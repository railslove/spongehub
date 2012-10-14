class RatingsController < ApplicationController

  before_filter :authentication_required
  before_filter :load_and_ensure_space
  before_filter :check_space_membership

  def create
    @rating = @space.ratings.new(params[:rating], :creator => current_user)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @space, notice: 'Rating was successfully created.' }
        format.json { render json: @rating, status: :created, location: [@space, @rating] }
      else
        format.html { redirect_to @space, alert: 'Something went wrong. Maybe you forgot the descritpion?' }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating = @space.ratings.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to space_ratings_url(@space) }
      format.json { head :no_content }
    end
  end
end

class RatingsController < ApplicationController

  before_filter :authentication_required
  before_filter :load_and_ensure_space

  def index
    @ratings = @space.ratings.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  def show
    @rating = @space.ratings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end

  def new
    @rating = @space.ratings.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end

  def edit
    @rating = @space.ratings.find(params[:id])
  end

  def create
    @rating = @space.ratings.new(params[:rating], :creator => current_user)

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @space, notice: 'Rating was successfully created.' }
        format.json { render json: @rating, status: :created, location: [@space, @rating] }
      else
        format.html { render action: "new" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @rating = @space.ratings.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
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

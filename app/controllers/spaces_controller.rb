class SpacesController < ApplicationController

  before_filter :authentication_required, :except => [:show, :index]

  def index
    @spaces = Space.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spaces }
    end
  end

  def show
    @space = Space.find(params[:id])
    @ranked_users = @space.users.with_karma
    @recent_blames = @space.blames.limit(5).order('created_at DESC')
    @recent_fames = @space.fames.limit(5).order('created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @space }
    end
  end

  def new
    @space = Space.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @space }
    end
  end

  def edit
    @space = Space.find(params[:id])
  end

  def create
    @space = Space.new(params[:space])

    respond_to do |format|
      if @space.save
        @space.users << current_user
        format.html { redirect_to @space, notice: 'Space was successfully created.' }
        format.json { render json: @space, status: :created, location: @space }
      else
        format.html { render action: "new" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @space = Space.find(params[:id])

    respond_to do |format|
      if @space.update_attributes(params[:space])
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @space = Space.find(params[:id])
    @space.destroy

    respond_to do |format|
      format.html { redirect_to spaces_url }
      format.json { head :no_content }
    end
  end
end

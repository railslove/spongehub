class ChoresController < ApplicationController

  before_filter :authentication_required
  before_filter :load_and_ensure_space

  def index
    @chores = @space.chores.all

    @month_chores = @space.chores.for_month(Date.today).group_by{ |chore| chore.due_at.to_date }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chores }
    end
  end

  def show
    @chore = @space.chores.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chore }
    end
  end

  def new
    @chore = @space.chores.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chore }
    end
  end

  def edit
    @chore = @space.chores.find(params[:id])
  end

  def create
    @chore = @space.chores.new(params[:chore])
    @chore.creator = current_user

    respond_to do |format|
      if @chore.save
        format.html { redirect_to [@space, @chore], notice: 'Chore was successfully created.' }
        format.json { render json: @chore, status: :created, location: @chore }
      else
        format.html { render action: "new" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @chore = @space.chores.find(params[:id])

    respond_to do |format|
      if @chore.update_attributes(params[:chore])
        format.html { redirect_to [@space, @chore], notice: 'Chore was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  def take
    @chore = @space.chores.find(params[:id])

    @chore.taker = current_user

    respond_to do |format|
      if @chore.save
        format.html { redirect_to [@space, @chore], notice: 'Chore was successfully taken.' }
        format.json { head :no_content }
      else
        format.html { redirect_to [@space, @chore], alert: 'Error taking chore: #{@chore.errors.full_message}' }
        format.json { render json: @chore.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chore = @space.chores.find(params[:id])
    @chore.destroy

    respond_to do |format|
      format.html { redirect_to [@space, :chores] }
      format.json { head :no_content }
    end
  end


end

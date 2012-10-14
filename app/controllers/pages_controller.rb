class PagesController < ApplicationController

  def homepage
    @spaces = Space.where(promote: true).order('RAND()').limit(6)
  end

  def about
  end

end

class PagesController < ApplicationController

  def homepage
    @spaces = Space.limit(6)
  end

  def about
  end

end

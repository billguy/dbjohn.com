class HomeController < ApplicationController
  def index
    @latest_pics = Pic.latest(3)
  end
end

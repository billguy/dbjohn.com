class HomeController < ApplicationController
  def index
    @latest_pic = Pic.latest.first
  end
end

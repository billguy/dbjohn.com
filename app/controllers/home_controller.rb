class HomeController < ApplicationController
  def index
    @latest_pic = Pic.latest.first
    @latest_blogs = Blog.latest(2)
  end
end

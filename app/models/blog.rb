class Blog < ActiveRecord::Base

  include Navigatable

  validates_presence_of :title, :content

  paginates_per 4

end

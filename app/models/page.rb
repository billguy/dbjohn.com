class Page < ActiveRecord::Base

  has_paper_trail
  has_permalink(:title, true)

  validates_presence_of :title, :content

  def to_param
    permalink
  end

end

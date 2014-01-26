class Slogan < ActiveRecord::Base

  has_paper_trail

  validates_presence_of :title

  def self.random
    Slogan.where(active: true).sample(1).first
  end
end

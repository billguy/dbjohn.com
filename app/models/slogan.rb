class Slogan < ActiveRecord::Base

  validates_presence_of :title

  def self.random
    Slogan.where(active: true).sample(1).first
  end
end

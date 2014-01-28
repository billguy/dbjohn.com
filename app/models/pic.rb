class Pic < ActiveRecord::Base

  has_permalink
  has_paper_trail
  acts_as_taggable

  validates_presence_of :title, :caption
  has_attached_file :attachment, :styles => { :large => "700x363>", :medium => "300x300>", :thumb => "100x100>" }
  validates :attachment, :attachment_presence => true
  before_create :generate_token
  after_create :notify_admin, unless: :published?

  scope :latest, ->(num=1){
    where(published: true).order(created_at: :desc).limit(num)
  }

  def to_param
    permalink
  end

  def approve(token)
    update_column(:published, true) if self.token == token
  end

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end

  def notify_admin
    PicMailer.notify_admin(self).deliver
  end
end

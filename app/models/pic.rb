class Pic < ActiveRecord::Base

  has_permalink(:title, true)
  has_paper_trail
  acts_as_taggable
  #paginates_per 9

  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.force_parameterize = true

  validates_presence_of :title, :caption
  has_attached_file :attachment, :styles => { :large => "720x540>", :medium => "230x230#", :thumb => "100x100#" }
  validates :attachment, :attachment_presence => true
  before_create :generate_token
  after_create :notify_admin, unless: :published?

  after_post_process :load_exif

  scope :latest, ->(num=1){
    where(published: true).order(created_at: :desc).limit(num)
  }

  scope :filter_by, ->(filter=nil, published=true){
    case filter
      when /year/
        created = 1.year.ago
      when /month/
        created = 1.month.ago
      when /day/
        created = DateTime.now.beginning_of_day
      else
        created = 5.years.ago
    end
    if published
      where("pics.created_at > ? and pics.published = ?", created, published).order(created_at: :desc)
    else
      where("pics.created_at > ?", created).order(created_at: :desc)
    end
  }

  reverse_geocoded_by :latitude, :longitude do |obj,geo|
    obj.location  = [geo.first.city, " #{geo.first.state}"].join(",")
  end
  before_save :reverse_geocode, if: :gps?

  def to_param
    permalink
  end

  def next(published=true)
    published ? Pic.where("id > ? and published = ?", id, published).order("id ASC").first : Pic.where("id > ?", id).order("id ASC").first
  end

  def prev(published=true)
    published ? Pic.where("id < ? and published = ?", id, published).order("id DESC").first : Pic.where("id < ?", id).order("id DESC").first
  end

  def image?
    attachment && attachment_content_type =~ /image/
  end

  def video?
    attachment && attachment_content_type =~ /video/
  end

  def gps?
    self.latitude && self.longitude
  end

  def approve(token)
    update_column(:published, true) if self.token == token
  end

  def load_exif
    exif = EXIFR::JPEG.new(attachment.queued_for_write[:original].path)
    return if exif.nil? or not exif.exif?
    self.camera_model = exif.model if exif.model
    self.date_taken = exif.date_time if exif.date_time
    self.latitude = exif.gps_latitude if exif.gps_latitude
    self.longitude = exif.gps_longitude if exif.gps_longitude
  rescue
    false
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

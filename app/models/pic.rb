class Pic < ActiveRecord::Base

  include Navigatable

  has_paper_trail

  validates_presence_of :title, :caption

  has_attached_file :attachment, :processors => [:watermark],
                    :styles => {
                        :original => { :watermark_path => "#{Rails.root}/public/images/dbjohn_watermark.png" },
                        :large => "720x540>",
                        :medium => "230x230#",
                        :thumb => "100x100#"
                    }
  validates :attachment, :attachment_presence => true
  validates_attachment_content_type :attachment, :content_type => %w(image/jpeg image/jpg image/png)

  after_attachment_post_process :load_exif

  before_create :generate_token
  after_create :notify_admin, unless: :published?

  reverse_geocoded_by :latitude, :longitude do |obj,geo|
    obj.location  = [geo.first.city, " #{geo.first.state}"].join(",")
  end

  def image?
    self.attachment && self.attachment_content_type =~ /image/
  end

  def video?
    self.attachment && self.attachment_content_type =~ /video/
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
    self.longitude = (self.longitude * -1.0) if self.longitude #for some reason Aperture doesn't set geographic east correctly  so I'm setting longitude to negative
    reverse_geocode if self.latitude && self.longitude
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

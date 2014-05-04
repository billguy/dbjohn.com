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

  after_attachment_post_process :reverse_geocode, if: :geocodable?

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

  def geocodable?
    latitude && longitude
  end

  def exif?
    exif(:exif?)
  rescue EXIFR::MalformedJPEG
    false
  end

  def date_taken
    exif(:date_time).strftime("%m.%d.%y %l:%M%p") rescue nil if exif?
  end

  def camera_make
    exif(:make).titleize if exif?
  end

  def camera_model
    exif(:model) if exif?
  end

  def f_stop
    exif(:f_number).to_f if exif?
  end

  def exposure_time
    exif(:exposure_time).to_s if exif?
  end

  def iso
    exif(:iso_speed_ratings) if exif?
  end

  def latitude
    return unless exif?
    @gps ||= exif(:gps)
    return unless @gps
    @gps.latitude
  end

  def longitude
    return unless exif?
    @gps ||= exif(:gps)
    return unless @gps
    @gps.longitude
  end

  def details
    return unless exif?
    "f%s, ISO %s, %s" % [f_stop, iso, exposure_time]
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

  def exif(arg)
    @exif ||= EXIFR::JPEG.new(new_record? ? attachment.queued_for_write[:original].path : attachment.path)
    @exif.send(arg)
  end
end

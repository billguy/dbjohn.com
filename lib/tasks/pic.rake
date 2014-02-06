namespace :pic do
  require "#{Rails.root}/app/helpers/pics_helper"
  include PicsHelper

  desc 'Fetch pics from secret email address'
  task email: :environment do
    email = PicsHelper::fetch_email
    p '1'
    if email.present?
      p '2'
      caption = (email.multipart? ? email.text_part.body.decoded : email.body.decoded).encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "")
      attributes = { title: email.subject, caption: caption, sent_by: email.from.first}
      email.attachments.each do | attachment |
        p '3'
        if (attachment.content_type.start_with?('image/'))
          p '4'
          pic = Pic.new(attributes)
          filename = attachment.filename
          file = StringIO.new(attachment.decoded)
          file.class.class_eval { attr_accessor :original_filename, :content_type }
          file.original_filename = filename
          file.content_type = attachment.mime_type
          pic.title = filename unless pic.title.present?
          pic.caption = filename unless pic.caption.present?
          pic.attachment = file
          pic.tag_list.add("mobile") if pic.save!
        end
      end
    end
  end
end
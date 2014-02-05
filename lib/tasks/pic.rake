namespace :pic do
  require "#{Rails.root}/app/helpers/pics_helper"
  include PicsHelper

  desc 'Fetch pics from secret email address'
  task email: :environment do
    email = PicsHelper::fetch_email
    if email
      caption = (email.multipart? ? email.text_part.body.decoded : email.body.decoded).encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "")
      attributes = { title: email.subject || 'On the go', caption: caption || 'On the go', sent_by: email.from.first}
      email.attachments.each do | attachment |
        filename = attachment.filename
        file = StringIO.new(attachment.decoded)
        file.class.class_eval { attr_accessor :original_filename, :content_type }
        file.original_filename = filename
        file.content_type = attachment.mime_type
        attributes[:title] = filename unless attributes[:title]
        attributes[:caption] = filename unless attributes[:caption]
        pic = Pic.create(attributes.reverse_merge(attachment: file))
        pic.tag_list.add("mobile") if pic
      end
    end
  end
end
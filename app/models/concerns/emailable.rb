module Emailable

  extend ActiveSupport::Concern

  module ClassMethods

    def receive_email(email)
      authorized = email.from & APP_CONFIG['pics_authorized_emails']
      if authorized.any?
        caption = (email.multipart? ? email.text_part.body.decoded : email.body.decoded).encode("UTF-8", :invalid => :replace, :undef => :replace, :replace => "")
        attributes = { title: email.subject, caption: caption, sent_by: email.from.first}
        email.attachments.each do | attachment |
          if (attachment.content_type.start_with?('image/'))
            pic = Pic.new(attributes)
            filename = attachment.filename
            file = StringIO.new(attachment.decoded)
            file.class.class_eval { attr_accessor :original_filename, :content_type }
            file.original_filename = filename
            file.content_type = attachment.mime_type
            pic.title = filename unless pic.title.present?
            pic.caption = filename unless pic.caption.present?
            pic.attachment = file
            if pic.save!
              pic.tag_list.add("mobile")
              pic.save!
            end
          end
        end
      end
    end
  end

end
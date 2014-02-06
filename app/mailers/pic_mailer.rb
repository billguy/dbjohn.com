class PicMailer < ActionMailer::Base
  default from: APP_CONFIG['admin_email']

  def notify_admin(pic)
    @pic = pic
    attachments.inline[@pic.attachment_file_name] = {:mime_type => @pic.attachment_content_type, :content => File.read(@pic.attachment.queued_for_write[:original].path)} unless Rails.env.test?
    mail(to: APP_CONFIG['admin_email'], subject: 'New pic pending your approval')
  end
end

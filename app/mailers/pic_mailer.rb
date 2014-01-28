class PicMailer < ActionMailer::Base
  default from: APP_CONFIG['admin_email']

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.pic_mailer.notify_admin.subject
  #
  def notify_admin(pic)
    @pic = pic
    attachments.inline[@pic.attachment_file_name] = {:mime_type => @pic.attachment_content_type, :content => File.read(@pic.attachment.path)}
    mail(to: APP_CONFIG['admin_email'], subject: 'New pic pending your approval')
  end
end

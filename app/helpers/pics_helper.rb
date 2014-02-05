module PicsHelper
  require "mailman"

  def fetch_email
    Mailman.config.logger = Logger.new File.expand_path("../../../log/mailman_pics_#{Rails.env}.log", __FILE__)
    Mailman.config.poll_interval = 0
    Mailman.config.imap = {
        server: APP_CONFIG['pics_mail_host'], port: APP_CONFIG['pics_mail_port'], ssl: APP_CONFIG['pics_mail_ssl'],
        username: APP_CONFIG['pics_mail_address'],
        password: APP_CONFIG['pics_mail_pass']
    }
    email = nil
    Mailman::Application.run do
      APP_CONFIG['pics_authorized_emails'].each do |e|
        from(e) do
          begin
            email = message
          rescue Exception => e
            Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
            Mailman.logger.error [e, *e.backtrace].join("\n")
            #TicketMailer.exception_notification(message,e).deliver
          end
        end
      end
    end
    email
  end
end

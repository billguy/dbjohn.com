namespace :pic do


  def fetch_from_email
    require "mailman"
    require File.dirname(__FILE__) + "/../../config/environment"

    Mailman.config.ignore_stdin = true
    Mailman.config.logger = Logger.new File.expand_path("../../../log/mailman_pics_#{Rails.env}.log", __FILE__)

    if Rails.env.test?
      Mailman.config.maildir = File.expand_path("../../../tmp/test_maildir", __FILE__)
    else
      Mailman.config.poll_interval = 0
      Mailman.config.pop3 = {
          server: APP_CONFIG['pics_mail_host'], port: APP_CONFIG['pics_mail_port'], ssl: APP_CONFIG['pics_mail_ssl'],
          username: APP_CONFIG['pics_mail_address'],
          password: APP_CONFIG['pics_mail_pass']
      }

    end

    Mailman::Application.run do

      from(APP_CONFIG['pics_authorized_emails']).to(APP_CONFIG['pics_mail_address']) do
        begin
          #Pic.create_from_message
        rescue Exception => e
          Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
          Mailman.logger.error [e, *e.backtrace].join("\n")
          #TicketMailer.exception_notification(message,e).deliver
        end
      end

    end

  end

  desc 'Fetch pics from secret email address'
  task email: :environment do
    fetch_from_email
  end
end
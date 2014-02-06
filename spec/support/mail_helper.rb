module MailHelpers
  def mail_with_attachment(to_email, from_email)

    @mail = Mail.new do
      to      to_email
      from    from_email
      #subject 'RSpec Testing'

      text_part do
        body nil
      end
      #
      #html_part do
      #  content_type 'text/html; charset=UTF-8'
      #  body '<h1>Funky Title</h1><p>Here is the attachment you wanted</p>'
      #end

      add_file 'spec/support/testing.png'
    end
  end
end
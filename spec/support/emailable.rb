shared_examples_for "emailable" do

  include MailHelpers

  describe '#receive_mail' do

    let(:authorized_email) { mail_with_attachment("#{APP_CONFIG['pics_mail_address']}@#{APP_CONFIG['smtp_domain']}", APP_CONFIG['pics_authorized_emails'].first) }
    let(:unauthorized_email) { mail_with_attachment("#{APP_CONFIG['pics_mail_address']}@#{APP_CONFIG['smtp_domain']}", "some_jarook@email.com") }

    it 'creates a new pic from an auth email' do
      expect{Pic.send(:receive_email, authorized_email)}.to change{Pic.count}.by(1)
    end

    it 'does not create a new pic from an unauth email' do
      expect{Pic.send(:receive_email, unauthorized_email)}.to_not change{Pic.count}
    end

  end

end

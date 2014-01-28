require "spec_helper"

describe PicMailer do
  describe "notify_admin" do
    let(:pic) { FactoryGirl.create(:pic) }
    let(:mail) { PicMailer.notify_admin(pic) }

    it "renders the headers" do
      mail.subject.should include("pending")
      mail.to.should eq([APP_CONFIG['admin_email']])
      mail.from.should eq([APP_CONFIG['admin_email']])
    end

    it "renders the body" do
      mail.body.encoded.should include(pic.token)
    end
  end

end

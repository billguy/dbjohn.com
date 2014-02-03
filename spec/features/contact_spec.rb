require "spec_helper"

feature "Contact" do

  let(:contact) { FactoryGirl.build(:contact)}
  before do
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.deliveries = []
  end

  scenario "it does not submit invalid" do
    visit new_contact_path
    click_button "Send"
    page.should have_content("can't be blank")
  end

  scenario "valid form redirects to home" do
    visit new_contact_path
    Contact.any_instance.stub(:valid?){ true }
    fill_in "Name", with: "test"
    fill_in "Email", with: "test@test.com"
    fill_in "Message", with: "test"
    click_button "Send"
    current_path.should == root_path
    ActionMailer::Base.deliveries.count.should == 1
  end

  scenario "captcha present" do
    visit new_contact_path
    page.should have_selector("input#contact_textcaptcha_answer")
  end

end
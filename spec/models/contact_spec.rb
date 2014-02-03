require 'spec_helper'

describe Contact do

  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }
  it { should respond_to(:email) }
  it { should validate_presence_of(:email) }
  it { should respond_to(:message) }
  it { should validate_presence_of(:message) }

  it "validates email is an email" do
    Contact.any_instance.stub(:validate_textcaptcha).and_return(true)
    valid_contact = FactoryGirl.build(:contact)
    invalid_contact = FactoryGirl.build(:contact, email: "invalid")
    valid_contact.should be_valid
    invalid_contact.should_not be_valid
  end

end
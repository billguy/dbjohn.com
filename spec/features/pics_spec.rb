require 'spec_helper'

feature "Pics" do
  before do
    Pic.any_instance.stub(:notify_admin).and_return(nil)
  end
  scenario "approve a pic" do
    pic = FactoryGirl.create(:pic)
    visit approve_pic_path(pic, token: pic.token)
    current_path.should == pic_path(pic)
  end

  scenario "do not approve a pic" do
    pic = FactoryGirl.create(:pic)
    visit approve_pic_path(pic, token: '123')
    current_path.should == root_path
  end

end
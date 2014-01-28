require 'spec_helper'

feature "Pics" do
  scenario "approve a pic" do
    pic = FactoryGirl.create(:pic)
    visit approve_pic_path(pic, token: pic.token)
    page.should have_content("published")
  end



end
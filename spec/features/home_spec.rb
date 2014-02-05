require 'spec_helper'

feature "Home Page" do
  scenario "it works" do
    visit root_path
    page.status_code.should == 200
  end

  scenario "has slogan" do
    visit root_path
    page.find('#slogan').should have_content("David B. John")
  end
end
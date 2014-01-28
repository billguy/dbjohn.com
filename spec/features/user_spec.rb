require "spec_helper"

feature 'sign in' do
  scenario 'redirects after login' do
    user = FactoryGirl.create(:user)
    visit new_pic_path
    current_path.should == new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'
    current_path.should == new_pic_path
  end
end
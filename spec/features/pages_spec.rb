require "spec_helper"

feature 'Pages' do

  let(:ppage) { FactoryGirl.create(:page) }

  scenario 'visit page' do
    visit page_path(ppage)
    page.status_code.should == 200
  end

  scenario 'can not create, edit or destroy' do
    visit edit_page_path(ppage)
    current_path.should == new_user_session_path
    visit new_page_path
    current_path.should == new_user_session_path
    page.driver.submit :delete, page_path(ppage), {}
    current_path.should == new_user_session_path
  end

  feature 'as admin' do

    scenario 'redirects to page after create/edit' do
      login
      visit new_page_path
      fill_in "Title", with: "Page Title"
      fill_in "Content", with: "created page"
      click_button 'Save'
      expect(page).to have_title "Page Title"
      page.should have_content("created page")
    end

    scenario 'edit in place' do
      login
      visit page_path(ppage)
      page.should have_selector("#edit_button")
    end
  end

end
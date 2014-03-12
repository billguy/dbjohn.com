require 'spec_helper'

feature "redirects old wp posts to blog" do

  scenario "it does not croak" do
    visit root_path + '2012/01/20/google-translate-api-v2-and-codeigniter%20Result:%20chosen%20nickname%20%22jolinelaprairie095%22;%20ReCaptcha%20decoded;%20(JS);%20success%20(from%20first%20page)'
    page.status_code.should == 200
  end

end
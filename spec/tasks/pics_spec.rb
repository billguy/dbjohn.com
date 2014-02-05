require 'spec_helper'
require 'rake'
include MailHelpers

describe 'pic:email' do
  before do
    DbjohnCom::Application.load_tasks
  end

  let(:run_rake_task) { Rake::Task['pic:email'].invoke }

  it 'creates a new pic from an auth email' do
    authorized_email = mail_with_attachment("#{APP_CONFIG['pics_mail_address']}@#{APP_CONFIG['smtp_domain']}", APP_CONFIG['pics_authorized_emails'].first)
    PicsHelper.stub(:fetch_email).and_return(authorized_email)
    Pic.any_instance.stub(:notify_admin).and_return(nil)
    expect { run_rake_task }.to change{ Pic.count}.by(1)
  end

  it 'does not create a new pic from an unauth email' do
    unauthorized_email = mail_with_attachment("#{APP_CONFIG['pics_mail_address']}@#{APP_CONFIG['smtp_domain']}", "invalid@email.com".first)
    PicsHelper.stub(:fetch_email).and_return(unauthorized_email)
    expect { run_rake_task }.not_to change{ Pic.count}
  end

  it 'does not croak' do
    PicsHelper.stub(:fetch_email).and_return(nil)
    expect { run_rake_task }.not_to raise_exception
  end

end
require 'spec_helper'
require 'rake'
include MailHelpers

describe 'pic:email' do
  before do
    DbjohnCom::Application.load_tasks
    PicsHelper.stub(:fetch_email).and_return(nil)
  end

  let(:run_rake_task) { Rake::Task['pic:email'].invoke }

  it { expect { run_rake_task }.not_to raise_exception }

  it 'should create a new pic from an email' do
    authorized_email = mail_with_attachment(APP_CONFIG['pics_mail_address'], APP_CONFIG['pics_authorized_emails'].first)
    PicsHelper.stub(:fetch_email).and_return(authorized_email)
    Pic.any_instance.should_receive :create
    run_rake_task
  end

end
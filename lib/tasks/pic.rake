namespace :pic do
  require "#{Rails.root}/app/helpers/pics_helper"
  include PicsHelper

  desc 'Fetch pics from quasi secret email address'
  task email: :environment do
    PicsHelper.fetch_email
  end
end
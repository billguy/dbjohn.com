# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pic do
    published false
    title "MyString"
    permalink nil
    attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'testing.png'), 'image/png') }
    caption "MyText"
    token nil
    sent_by nil
    latitude nil
    longitude nil
    camera_model nil
    date_taken nil
    created_at nil
  end

  factory :pic_gps, class: Pic do
    published false
    title "MyString"
    permalink nil
    attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'testing_gps.jpg'), 'image/jpg') }
    caption "MyText"
    token nil
    sent_by nil
    latitude nil
    longitude nil
    camera_model nil
    date_taken nil
  end


end

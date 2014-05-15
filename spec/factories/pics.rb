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
    created_at nil

    factory :pic_gps, class: Pic do
      attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'testing_gps.jpg'), 'image/jpg') }
    end

    factory :pic_without_gps, class: Pic do
      attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'test_wo_gps.jpg'), 'image/jpg') }
    end

    factory :pic_with_crazy_filename do
      attachment { fixture_file_upload(Rails.root.join('spec', 'support', 'a crazy%file(name).jpg'), 'image/jpg') }
    end

  end

end

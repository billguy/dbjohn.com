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
  end
end

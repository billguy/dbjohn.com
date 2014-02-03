# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
    published false
    title "MyString"
    permalink "MyString"
    content "MyText"
  end
end

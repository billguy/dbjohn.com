# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "MyString"
    permalink nil
    content "MyText"
    javascript "MyText"
  end
end

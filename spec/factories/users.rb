# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "David John"
    email "dj@dbjohn.com"
    password "password"
    password_confirmation "password"

    #factory :user_with_published_articles do
    #  email "djohn2@arch-no.org"
    #  after(:create) do |user, evaluator|
    #    create_list(:article, 3, user: user, published: true)
    #  end
    #end
    #
    #factory :user_with_unpublished_articles do
    #  email "djohn3@arch-no.org"
    #  after(:create) do |user, evaluator|
    #    create_list(:article, 3, user: user)
    #  end
    #end

  end
end

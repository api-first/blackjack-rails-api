FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "sean-#{n}" }
    password "drowssap"

    trait :with_email do
      sequence(:email) { |n| "david#{"+#{n}" if n > 0}@example.com" }
    end
  end
end

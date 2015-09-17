FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "sean-#{n}" }
    password "drowssap"
  end
end

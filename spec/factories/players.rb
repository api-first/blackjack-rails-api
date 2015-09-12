FactoryGirl.define do
  factory :player do
    association :user, strategy: :build
  end
end

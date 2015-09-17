FactoryGirl.define do
  factory :player do
    association :user, strategy: :build
    name "Barney"
  end
end

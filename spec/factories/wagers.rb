FactoryGirl.define do
  factory :wager do
    amount 100
    association :hand, strategy: :build
    association :player, strategy: :build
  end
end

FactoryGirl.define do
  factory :channel_subscription do
    association :channel, strategy: :build
    association :subscriber, factory: :player, strategy: :build
  end
end

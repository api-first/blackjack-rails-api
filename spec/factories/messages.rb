FactoryGirl.define do
  factory :message do
    association :channel, strategy: :build
    body "Hi!"
  end
end

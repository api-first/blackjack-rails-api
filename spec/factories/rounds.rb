FactoryGirl.define do
  factory :round do
    association :table, strategy: :build
    initial_betting_closed_at Time.now + 30.seconds
  end
end

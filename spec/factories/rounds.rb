FactoryGirl.define do
  factory :round do
    association :table, strategy: :build
    initial_betting_closed_at "2015-09-10 12:43:05"
  end
end

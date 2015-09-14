FactoryGirl.define do
  factory :hand do
    association :round, strategy: :build
    position 1
  end
end

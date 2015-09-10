FactoryGirl.define do
  factory :table do
    association :table_rule_set, strategy: :build
  end
end

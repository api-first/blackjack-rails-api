FactoryGirl.define do
  factory :table_player_position do
    association :table, strategy: :build
    position 1
    association :player, strategy: :build
  end
end

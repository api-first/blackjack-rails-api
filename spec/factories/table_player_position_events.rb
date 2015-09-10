FactoryGirl.define do
  factory :table_player_position_event do
    association :table, strategy: :build
    association :player, strategy: :build
    position 1
    event 0
  end
end

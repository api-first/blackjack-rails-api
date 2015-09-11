FactoryGirl.define do
  factory :hand do
    association :round, strategy: :build
    association :table_player_position, strategy: :build
    after :build do |hand|
      hand.table_player_position.table = hand.round.table
    end
  end
end

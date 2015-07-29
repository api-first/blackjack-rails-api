FactoryGirl.define do
  factory :card do
    association :rank, strategy: :build
    association :suit, strategy: :build

    initialize_with do
      new(rank, suit)
    end
  end
end

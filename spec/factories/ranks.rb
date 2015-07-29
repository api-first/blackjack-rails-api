FactoryGirl.define do
  factory :rank do
    initial "A"
    name "Ace"
    (2..10).each do |n|
      factory n do
        initial n.to_s
        name n.to_s
      end
    end
    factory :jack do
      initial "J"
      name "Jack"
    end
    factory :queen do
      initial "Q"
      name "Queen"
    end
    factory :king do
      initial "K"
      name "King"
    end
    factory :ace do
      initial "A"
      name "Ace"
    end
  end
end

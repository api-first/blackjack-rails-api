FactoryGirl.define do
  factory :rank do
    initial "A"
    name "Ace"
    values [1,11]
    (2..10).each do |n|
      factory n do
        initial n.to_s
        name n.to_s
        values [n]
      end
    end
    factory :jack do
      initial "J"
      name "Jack"
      values [10]
    end
    factory :queen do
      initial "Q"
      name "Queen"
      values [10]
    end
    factory :king do
      initial "K"
      name "King"
      values [10]
    end
    factory :ace do
      initial "A"
      name "Ace"
      values [1,11]
    end
  end
end

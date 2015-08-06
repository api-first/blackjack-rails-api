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
        order n - 2
      end
    end
    factory :jack do
      initial "J"
      name "Jack"
      values [10]
      order 9
    end
    factory :queen do
      initial "Q"
      name "Queen"
      values [10]
      order 10
    end
    factory :king do
      initial "K"
      name "King"
      values [10]
      order 11
    end
    factory :ace do
      initial "A"
      name "Ace"
      values [1,11]
      order 12
    end

    initialize_with do
      Rank.find_or_initialize_by(initial: initial, name: name)
    end
  end
end

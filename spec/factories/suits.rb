FactoryGirl.define do
  factory :suit do
    name "spades"
    color "black"
    factory :spades do
      name "spades"
      color "black"
    end
    factory :clubs do
      name "clubs"
      color "black"
    end
    factory :hearts do
      name "hearts"
      color "red"
    end
    factory :diamonds do
      name "diamonds"
    end
  end
end

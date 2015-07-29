FactoryGirl.define do
  factory :suit do
    initial "S"
    name "spades"
    color "black"
    factory :spades do
      initial "S"
      name "spades"
      color "black"
    end
    factory :clubs do
      initial "C"
      name "clubs"
      color "black"
    end
    factory :hearts do
      initial "H"
      name "hearts"
      color "red"
    end
    factory :diamonds do
      initial "D"
      name "diamonds"
      color "red"
    end
  end
end

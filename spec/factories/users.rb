FactoryGirl.define do
  factory :user do
    username "sean"
    password "drowssa"
    birth_date Date.new(1975,3,5)
  end
end

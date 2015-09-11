FactoryGirl.define do
  factory :hand_card do
    association :hand, strategy: :build
    card_id "AS"
    face_up true
  end
end

FactoryGirl.define do
  factory :transaction do
    kind "deposit"
    amount "9.99"
    association :player, strategy: :build
    factory :transaction_deposit do
      kind "deposit"
      amount "100"
    end
    factory :transaction_wager do
      kind "wager"
      amount "-25"
      before :create do |transaction|
        
      end
    end
    factory :transaction_win do
      kind "win"
      amount "50"
    end
    factory :transaction_withdrawal do
      kind "withdrawal"
      amount "-125"
    end
  end
end

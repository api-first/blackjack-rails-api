namespace :seed do
  task suits: :environment do
    [
      ["S", "spades", "black"],
      ["C", "clubs", "black"],
      ["H", "hearts", "red"],
      ["D", "diamonds", "red"]
    ].each do |initial, name, color|
      Suit.find_or_create_by!(initial: initial, name: name, color: Suit.colors[color])
    end
  end

  task ranks: :environment do
    ranks = []
    pips = (2..10).to_a
    ranks += pips.zip(pips)

    ranks +=  [
      ["J", "Jack"],
      ["Q", "Queen"],
      ["K", "King"],
      ["A", "Ace"]
    ]

    ranks.each do |initial, name|
      Rank.find_or_create_by!(initial: initial, name: name)
    end
  end
end

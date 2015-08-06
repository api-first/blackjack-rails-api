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
    ranks =  [
      ["2", "2", [2]],
      ["3", "3", [3]],
      ["4", "4", [4]],
      ["5", "5", [5]],
      ["6", "6", [6]],
      ["7", "7", [7]],
      ["8", "8", [8]],
      ["9", "9", [9]],
      ["10", "10", [10]],
      ["J", "Jack", [10]],
      ["Q", "Queen", [10]],
      ["K", "King", [10]],
      ["A", "Ace", [1,11]]
    ]

    ranks.each do |initial, name, values|
      Rank.find_or_initialize_by(initial: initial, name: name).tap do |rank|
        rank.values = values
      end.save!
    end
  end
end

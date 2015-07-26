namespace :seed do
  task suits: :environment do
    [
      ["spades", "black"],
      ["clubs", "black"],
      ["hearts", "red"],
      ["diamonds", "red"]
    ].each do |name, color|
      Suit.find_or_create_by!(name: name, color: Suit.colors[color])
    end
  end
end

RSpec.describe PlayerHandHistory do

  let! :player do
    FactoryGirl.create(:player)
  end

  let :position do
    1
  end


  subject do
    described_class.new(Player.where(id: player.id), Table.all, position)
  end

  context "when the player was at the table and position" do
    before do
      FactoryGirl.create(:table_player_position,
        player: player,
        position: position
      )
    end
    it "has the hand in scope" do
      expect(subject.all.count).to eq 1
    end
  end

  context "when the player was at the table at the time but in a different position" do
    before do
      FactoryGirl.create(:table_player_position,
        player: player,
        position: position + 1
      )
    end
    it "does not have the hand in scope" do
      expect(subject.all.count).to eq 0
    end
  end

  context "when the player was not at the table at the time" do
    before do
      FactoryGirl.create(:table_player_position,
        player: player,
        position: position,
        created_at: Time.now + 1.minute,
        updated_at: Time.now + 1.minute
      )
    end
    it "does not have the hand in scope" do
      expect(subject.all.count).to eq 0
    end
  end

end

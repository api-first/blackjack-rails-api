module V1
  RSpec.describe RankResource do
    include_examples "read only resource"

    it "has the fetchable fields id, initial, and name" do
      expect(described_class.new(Rank.new).fetchable_fields.sort).to eq [:id, :initial, :name].sort
    end
  end
end

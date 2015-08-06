module V1
  RSpec.describe RankResource do
    include_examples "read only resource"

    it "has the fetchable fields id, initial, name, values, and order" do
      expect(described_class.new(Rank.new).fetchable_fields.sort).to eq [:id, :initial, :name, :values, :order].sort
    end
  end
end

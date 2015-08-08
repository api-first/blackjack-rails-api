module V1
  RSpec.describe SuitResource do
    include_examples "read only resource"

    it "has the fetchable fields name and color" do
      expect(described_class.new(Suit.new).fetchable_fields.sort).to eq [:id, :created_at, :updated_at, :initial, :color].sort
    end
  end
end

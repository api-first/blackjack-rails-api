module V1
  RSpec.describe CardResource do
    include_examples "read only resource"

    it "has the fetchable fields name and color" do
      expect(described_class.new(FactoryGirl.build(:card)).fetchable_fields.sort).to eq [:id, :rank, :suit].sort
    end
  end
end

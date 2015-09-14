module V1
  RSpec.describe TablePlayerPositionResource do

    let :creatable_fields do
      [
        :table,
        :player,
        :position,
      ].sort
    end

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq creatable_fields
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq []
    end

    it "can fetch the correct fields" do
      expect(described_class.new(TablePlayerPosition.new).fetchable_fields.sort).to eq(
        (creatable_fields + [:id, :created_at, :updated_at, :hands, :current_hands]).sort
      )
    end

  end
end

module V1
  RSpec.describe RoundResource do

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq []
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq []
    end

    it "can fetch the correct fields" do
      expect(described_class.new(Table.new).fetchable_fields.sort).to eq ([
        :id,
        :created_at,
        :updated_at,
        :initial_betting_closed_at,
        :table,
        :active
      ]).sort
    end

  end
end

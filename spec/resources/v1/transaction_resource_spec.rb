module V1
  RSpec.describe TransactionResource do

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq [].sort
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq []
    end

    it "can fetch the correct fields" do
      expect(described_class.new(Table.new).fetchable_fields.sort).to eq ([
        :id,
        :created_at,
        :updated_at,
        :player,
        :amount,
        :kind,
        :action
      ]).sort
    end

  end
end

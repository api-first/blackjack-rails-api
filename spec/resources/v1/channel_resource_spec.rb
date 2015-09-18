module V1
  RSpec.describe ChannelResource do

    let :creatable_and_updatable_fields do
      [
        :status,
        :name,
        :description
      ].sort
    end

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can fetch the correct fields" do
      expect(described_class.new(Channel.new).fetchable_fields.sort).to eq (creatable_and_updatable_fields + [:id, :created_at, :updated_at, :messages]).sort
    end

  end
end

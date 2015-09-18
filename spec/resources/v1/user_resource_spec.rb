module V1
  RSpec.describe UserResource do

    let :creatable_and_updatable_fields do
      [
        :username,
        :password
      ].sort
    end

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can fetch the correct fields" do
      expect(described_class.new(Table.new).fetchable_fields.sort).to eq (creatable_and_updatable_fields + [:id, :created_at, :updated_at, :pit_boss, :players] - [:password]).sort
    end

    context "when the current user is a pit_boss" do
      it "can create a user that is a pit boss" do
        expect(described_class.creatable_fields(current_user: double(User, pit_boss?: true)).sort).to eq (creatable_and_updatable_fields + [:pit_boss]).sort
      end
      it "can update the pit_boss attribute of another user" do
        expect(described_class.updatable_fields(current_user: double(User, pit_boss?: true)).sort).to eq (creatable_and_updatable_fields + [:pit_boss]).sort
      end
    end

  end
end

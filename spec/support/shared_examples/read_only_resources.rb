RSpec.shared_examples "read only resource" do

  it "has no creatable fields" do
    expect(described_class.creatable_fields(nil)).to eq []
  end

  it "has no updatable fields" do
    expect(described_class.updatable_fields(nil)).to eq []
  end
  
end

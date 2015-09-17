RSpec.describe Channel do

  it "can set and get the name" do
    subject.name = "name"
    expect(subject.name).to eq "name"
  end

  it "can set and get the attribute" do
    subject.description = "description"
    expect(subject.description).to eq "description"
  end

  it "has the expected statuses" do
    expect(described_class.statuses).to eq({
      "open" => 0,
      "closed" => 1
    })
  end

  it "channel is initialized as open" do
    expect(subject.status).to eq "open"
  end

  it "has many messages" do
    expect(subject.messages.new).to be_a Message
  end

end

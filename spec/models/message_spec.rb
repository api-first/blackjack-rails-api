RSpec.describe Message do

  it "belongs to a channel" do
    expect(subject.build_channel).to be_a Channel
  end

  it "validates that the channel is present" do
    subject.channel = nil
    subject.valid?
    expect(subject.errors[:channel]).to include "can't be blank"
  end

  it "belongs to an author" do
    player = Player.new
    subject.author = player
    expect(subject.author).to eq player
  end

  it "can get and set its body" do
    body = "hi"
    subject.body = body
    expect(subject.body).to eq body
  end

  it "validates that the body is present" do
    subject.body = nil
    subject.valid?
    expect(subject.errors[:body]).to include "can't be blank"
  end

end

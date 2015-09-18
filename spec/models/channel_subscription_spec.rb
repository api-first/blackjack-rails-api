RSpec.describe ChannelSubscription do
  it "belongs to a channel" do
    channel = Channel.new
    subject.channel = channel
    expect(subject.channel).to eq channel
  end

  it "validates the presence of the channel" do
    subject.channel = nil
    subject.valid?
    expect(subject.errors[:channel]).to include "can't be blank"
  end

  it "belongs to a polymorphic subscriber" do
    player = Player.new
    user = User.new
    subject.subscriber = player
    expect(subject.subscriber).to eq player
    subject.subscriber = user
    expect(subject.subscriber).to eq user
  end

  it "validates the presence of the subscriber" do
    subject.subscriber = nil
    subject.valid?
    expect(subject.errors[:subscriber]).to include "can't be blank"
  end

  it "validates the uniqueness of channel and subscriber" do
    original = FactoryGirl.create(:channel_subscription)
    duplicate = ChannelSubscription.new
    duplicate.channel = original.channel
    duplicate.subscriber = original.subscriber
    duplicate.valid?
    expect(duplicate.errors[:channel_id]).to include "has already been taken for the subscriber"
  end
end

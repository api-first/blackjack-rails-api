require "api_documentation_helper"

RSpec.resource "ChannelSubscriptions", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/channel-subscriptions" do

    parameter :type, <<-DESC, required: true
      Must always be set to <code>channel-subscriptions</code>.
    DESC

    let :type do
      "channel-subscriptions"
    end

    parameter :channel, <<-DESC, scope: :relationships, required: true
      The channel of the subscription.
    DESC

    let :channel_id do
      FactoryGirl.create(:channel).id.to_s
    end

    let "channel" do
      {
        data: {
          type: "channels",
          id: channel_id
        }
      }
    end

    parameter :subscriber, <<-DESC, scope: :relationships, required: true
      The subscriber to the channel. Polymorphic in case we want to have players or users.
    DESC

    let :subscriber_id do
      FactoryGirl.create(:player).id.to_s
    end

    let "subscriber" do
      {
        data: {
          type: "players",
          id: subscriber_id
        }
      }
    end

    example_request "POST /v1/channel-subscriptions" do
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
      expect(parsed["data"]["relationships"]["channel"]["data"]["id"]).to eq channel_id
      expect(parsed["data"]["relationships"]["subscriber"]["data"]["type"]).to eq "players"
      expect(parsed["data"]["relationships"]["subscriber"]["data"]["id"]).to eq subscriber_id
    end
  end

  get "/v1/channel-subscriptions/:id" do
    let! :channel_subscription do
      FactoryGirl.create(:channel_subscription)
    end

    parameter :id, <<-DESC, required: true
      ID of the channel-subscription to be retrieved.
    DESC

    let :id do
      channel_subscription.id
    end

    example_request "GET /v1/channel-subscriptions/:id" do
      expect(status).to eq 200
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
    end
  end

  get "/v1/channel-subscriptions" do
    before do
      FactoryGirl.create(:channel_subscription)
    end

    example_request "GET /v1/channel-subscriptions" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

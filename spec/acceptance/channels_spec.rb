require "api_documentation_helper"

RSpec.resource "Channels", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/channels" do

    parameter :type, <<-DESC, required: true
      Must always be set to <code>channels</code>.
    DESC

    let :type do
      "channels"
    end

    parameter :status, <<-DESC, scope: :attributes
      The status of the channel. Valid values are #{Channel.statuses.keys.join(",")}.
    DESC

    let "status" do
      "closed"
    end

    parameter :name, <<-DESC, scope: :attributes
      The name of the channel.
    DESC

    let "name" do
      "Chitter Chatter"
    end

    parameter :description, <<-DESC, scope: :attributes
      The description of the channel.
    DESC

    let "description" do
      "A very interesting discussion."
    end

    example_request "POST /v1/channels" do
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
      expect(parsed["data"]["attributes"]["status"]).to eq "closed"
      expect(parsed["data"]["attributes"]["name"]).to eq name
      expect(parsed["data"]["attributes"]["description"]).to eq description
    end
  end

  get "/v1/channels/:id" do
    let! :channel do
      FactoryGirl.create(:channel)
    end

    parameter :id, <<-DESC, required: true
      ID of the channel to be retrieved.
    DESC

    let :id do
      channel.id
    end

    example_request "GET /v1/channels/:id" do
      expect(status).to eq 200
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
      expect(parsed["data"]["attributes"]["status"]).not_to be_nil
      expect(parsed["data"]["relationships"].keys).to include "messages"
    end
  end

  get "/v1/channels" do
    before do
      FactoryGirl.create(:channel)
    end

    example_request "GET /v1/channels" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

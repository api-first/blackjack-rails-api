require "api_documentation_helper"

RSpec.resource "Messages", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/messages" do

    parameter :type, <<-DESC, required: true
      Must always be set to <code>messages</code>.
    DESC

    let :type do
      "messages"
    end

    parameter :channel, <<-DESC, required: true, scope: :relationships
      The channel to which the message is being sent.
    DESC

    let :channel_id do
      FactoryGirl.create(:channel).id.to_s
    end

    let :channel do
      {
        data: {
          type: "channels",
          id: channel_id
        }
      }
    end

    parameter :author, <<-DESC, required: true, scope: :relationships
      The author of the message. Can be player or a user.
    DESC

    let :author_id do
      FactoryGirl.create(:player).id.to_s
    end

    let :author do
      {
        data: {
          type: "players",
          id: author_id
        }
      }
    end

    parameter :body, <<-DESC, required: true, scope: :attributes
      The body of the message.
    DESC

    let :body do
      "HIYA!"
    end

    example_request "POST /v1/messages" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
      expect(parsed["data"]["relationships"]["channel"]["data"]["id"]).to eq channel_id
      expect(parsed["data"]["relationships"]["author"]["data"]["id"]).to eq author_id
      expect(parsed["data"]["relationships"]["author"]["data"]["type"]).to eq "players"
      expect(parsed["data"]["attributes"]["body"]).to eq body
    end
  end

  get "/v1/messages/:id" do
    let! :message do
      FactoryGirl.create(:message)
    end

    parameter :id, <<-DESC, required: true
      ID of the message to be retrieved.
    DESC

    let :id do
      message.id
    end

    example_request "GET /v1/messages/:id" do
      expect(status).to eq 200
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
    end
  end

  get "/v1/messages" do
    before do
      FactoryGirl.create(:message)
    end

    example_request "GET /v1/messages" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

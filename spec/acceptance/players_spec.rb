require "api_documentation_helper"

RSpec.resource "Players", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/players" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>players</code>.
    DESC

    let :type do
      "players"
    end

    parameter "user", <<-DESC, required: true, scope: :relationships
      The related user.
    DESC

    let :user_id do
      FactoryGirl.create(:user).id.to_s
    end

    let "user" do
      {
        data: {
          id: user_id,
          type: "users"
        }
      }
    end

    example_request "POST /v1/players" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["relationships"]["user"]["data"]["id"]).to eq user_id
    end
  end

  get "/v1/players/:id" do
    let! :player do
      FactoryGirl.create(:player)
    end

    parameter :id, <<-DESC, required: true
      ID of the player to be retrieved.
    DESC

    let :id do
      player.id
    end

    example_request "GET /v1/players/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/players" do
    before do
      FactoryGirl.create(:player, user: @user)
    end

    example_request "GET /v1/players" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

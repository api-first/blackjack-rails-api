require "api_documentation_helper"

RSpec.resource "Players", :authenticated, :authorized do
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

    let! :user_id do
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

    parameter "name", <<-DESC, required: true, scope: :attributes
      The name of the player. Whatever you like!
    DESC

    let :name do
      "Barney"
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
    let! :player do
      FactoryGirl.create(:player, user: @user, name: "Barney")
    end

    example "GET /v1/players?filter[name]=" do
      explanation "This is a case insensitive search."
      do_request(filter: { name: "barney" })
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end

    example "GET /v1/players?sort=name" do
      explanation "Players may be sorted by name."
      player_two = FactoryGirl.create(:player, user: @user, name: "Alison")
      do_request(sort: "name")
      expect(JSON.parse(response_body)["data"][0]["id"]).to eq player_two.id.to_s
    end

    example "Filter by name and the player doesn't exist", document: false do
      do_request(filter: { name: "Fido"})
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 0
    end

    example_request "GET /v1/players" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

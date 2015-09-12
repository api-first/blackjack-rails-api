require "api_documentation_helper"

RSpec.resource "TablePlayerPositions", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/table-player-positions" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>table-player-positions</code>.
    DESC

    let :type do
      "table-player-positions"
    end

    let! :table_instance do
      FactoryGirl.create(:table)
    end

    let! :player_instance do
      FactoryGirl.create(:player)
    end

    parameter "table", <<-DESC, scope: :relationships, required: true
      The table of the table player position.
    DESC

    let "table" do
      {
        data: {
          id: table_instance.id.to_s,
          type: "tables"
        }
      }
    end

    parameter "player", <<-DESC, scope: :relationships, required: true
      The player of the table player position.
    DESC

    let "player" do
      {
        data: {
          id: player_instance.id.to_s,
          type: "players"
        }
      }
    end

    parameter "position", <<-DESC, scope: :attributes, required: true
      The position number of the table player position.
    DESC

    let "position" do
      1
    end

    example_request "POST /v1/table-player-positions" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["relationships"]["table"]["data"]["id"]).to eq table_instance.id.to_s
      expect(parsed["data"]["relationships"]["player"]["data"]["id"]).to eq player_instance.id.to_s
    end
  end

  get "/v1/table-player-positions/:id" do
    let! :table_player_position_instance do
      FactoryGirl.create(:table_player_position)
    end

    parameter :id, <<-DESC, required: true
      ID of the table player position to be retrieved.
    DESC

    let :id do
      table_player_position_instance.id.to_s
    end

    example_request "GET /v1/table-player-positions/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/table-player-positions" do
    before do
      FactoryGirl.create(:table_player_position)
    end

    example_request "GET /v1/table-player-positions" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

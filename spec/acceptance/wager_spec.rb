require "api_documentation_helper"

RSpec.resource "Wagers", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/wagers" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>wagers</code>.
    DESC

    let :type do
      "wagers"
    end

    let :existing_hand do
      FactoryGirl.create(:hand)
    end

    parameter "hand", <<-DESC, scope: :relationships, required: true
      The hand that the wager is being placed on.
    DESC

    let "hand" do
      {
        data: {
          id: existing_hand.id.to_s,
          type: "hands"
        }
      }
    end

    let :existing_player do
      FactoryGirl.create(:player)
    end

    parameter "player", <<-DESC, scope: :relationships, required: true
      The player that is placing the wager.
    DESC

    let "player" do
      {
        data: {
          id: existing_player.id.to_s,
          type: "players"
        }
      }
    end

    parameter "kind", <<-DESC, scope: :attributes, required: true
      The kind of wager that is being placed. Options are `intitial`.
    DESC

    let "kind" do
      "initial"
    end

    parameter "amount", <<-DESC, scope: :attributes, required: true
      The amount of the wager, as a decimal.
    DESC

    let "amount" do
      "25"
    end

    example_request "POST /v1/wagers" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["id"]).not_to be_nil
    end
  end

  get "/v1/wagers/:id" do
    let! :wager do
      FactoryGirl.create(:wager)
    end

    parameter :id, <<-DESC, required: true
      ID of the table to be retrieved.
    DESC

    let :id do
      wager.id.to_s
    end

    example_request "GET /v1/wagers/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/wagers" do
    before do
      FactoryGirl.create(:wager)
    end

    example_request "GET /v1/wagers" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

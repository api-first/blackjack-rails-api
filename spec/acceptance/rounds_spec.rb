require "api_documentation_helper"

RSpec.resource "Rounds", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/rounds/:id" do
    parameter :id, <<-DESC, required: true
      ID of the round to be retrieved.
    DESC

    let(:id) do
      FactoryGirl.create(:round).id.to_s
    end

    example_request "GET /v1/rounds/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["id"]).to eq id
    end
  end

  get "/v1/rounds" do
    before do
      FactoryGirl.create(:round)
    end
    example_request "GET /v1/rounds" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

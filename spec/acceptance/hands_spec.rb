require "api_documentation_helper"

RSpec.resource "Hands", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/hands/:id" do
    parameter :id, <<-DESC, required: true
      ID of the hand to be retrieved.
    DESC

    let(:id) do
      FactoryGirl.create(:hand).id.to_s
    end

    example_request "GET /v1/hands/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["id"]).to eq id
    end
  end

  get "/v1/hands" do
    before do
      FactoryGirl.create(:hand)
    end
    example_request "GET /v1/hands" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

require "api_documentation_helper"

RSpec.resource "Ranks" do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/ranks/:id" do
    parameter :id, <<-DESC, required: true
      ID of the rank to be retrieved.
    DESC

    let(:id) do
      "2"
    end

    example_request "GET /v1/ranks/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/ranks" do
    example_request "GET /v1/ranks" do
      expect(status).to eq 200
    end
  end

end

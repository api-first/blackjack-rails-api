require "api_documentation_helper"

RSpec.resource "Suits", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/suits/:id" do
    parameter :id, <<-DESC, required: true
      ID of the suit to be retrieved.
    DESC

    let(:id) do
      "S"
    end

    example_request "GET /v1/suits/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/suits" do
    example_request "GET /v1/suits" do
      expect(status).to eq 200
    end
  end

end

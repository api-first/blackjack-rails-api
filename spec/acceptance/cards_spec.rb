require "api_documentation_helper"

RSpec.resource "Cards", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/cards/:id" do
    parameter :id, <<-DESC, required: true
      The id of the card to be retrieved. It is a concatenation of the
      rank and suit initials (in that order). For example, the Ace of Spaces
      id is "AS".
    DESC

    let(:id) do
      "AS"
    end

    example_request "GET /v1/cards/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/cards" do
    example_request "GET /v1/cards" do
      expect(status).to eq 200
    end
  end

end

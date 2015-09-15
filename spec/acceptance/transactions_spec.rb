require "api_documentation_helper"

RSpec.resource "Transactions", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  get "/v1/transactions/:id" do
    parameter :id, <<-DESC, required: true
      ID of the transaction to be retrieved.
    DESC

    let(:id) do
      # creating a wager instead of a transaction just to show
      # what the polymorphic relationship looks like
      FactoryGirl.create(:wager).financial_transaction.id.to_s
    end

    example_request "GET /v1/transactions/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["id"]).to eq id
    end
  end

  get "/v1/transactions" do
    before do
      # creating a wager instead of a transaction just to show
      # what the polymorphic relationship looks like
      FactoryGirl.create(:wager)
    end
    example_request "GET /v1/transactions" do
      expect(status).to eq 200
      # the initial player credit transaction
      # and then the wager
      expect(JSON.parse(response_body)["data"].size).to eq 2
    end
  end

end

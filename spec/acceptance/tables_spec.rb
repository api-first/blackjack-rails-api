require "api_documentation_helper"

RSpec.resource "Tables", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/tables" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>tables</code>.
    DESC

    let :type do
      "tables"
    end

    let :table_rule_set do
      FactoryGirl.create(:table_rule_set)
    end

    parameter "table-rule-set", <<-DESC, scope: :relationships, required: true
      The rule set that governs the table.
    DESC

    let "table-rule-set" do
      {
        data: {
          id: table_rule_set.id.to_s,
          type: "table-rule-sets"
        }
      }
    end

    example_request "POST /v1/tables" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["relationships"]["table-rule-set"]["data"]["id"]).to eq table_rule_set.id.to_s
    end
  end

  get "/v1/tables/:id" do
    let! :table do
      FactoryGirl.create(:table)
    end

    parameter :id, <<-DESC, required: true
      ID of the table to be retrieved.
    DESC

    let :id do
      table.id
    end

    example_request "GET /v1/tables/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/tables" do
    before do
      FactoryGirl.create(:table)
    end

    example_request "GET /v1/tables" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

end

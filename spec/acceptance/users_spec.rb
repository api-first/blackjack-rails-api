require "api_documentation_helper"

RSpec.resource "Users", :authenticated, :authorized do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/users" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>users</code>.
    DESC

    let :type do
      "users"
    end

    parameter "username", <<-DESC, required: true, scope: :attributes
      The unique identifier for the user.
    DESC

    let "username" do
      "sean"
    end

    parameter "password", <<-DESC, required: true, scope: :attributes
      The password with which the user with authenticate.
    DESC

    let "password" do
      "drowssap"
    end

    parameter 'birth_date', <<-DESC, required: true, scope: :attributes
      Date of birth.
    DESC

    let 'birth_date' do
      Date.new(1975,3,5)
    end

    example_request "POST /v1/users" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["attributes"]["username"]).to eq "sean"
    end
  end

  get "/v1/users/:id" do
    parameter :id, <<-DESC, required: true
      ID of the user to be retrieved.
    DESC

    let :id do
      @user.id
    end

    example_request "GET /v1/users/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/users/me" do
    example_request "GET /v1/users/me" do
      explanation "Information about the authorized user."
      expect(JSON.parse(response_body)["data"]["id"]).to eq @user.id.to_s
    end
  end

  get "/v1/users" do
    example_request "GET /v1/users" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"].size).to eq 1
    end
  end

  patch "/v1/users/:_id" do
    parameter :id, <<-DESC, required: true
      ID of the user to be updated.
    DESC

    let :id do
      FactoryGirl.create(:user).id.to_s
    end

    let :_id do
      id
    end

    parameter :type, <<-DESC, required: true
      Must always be set to <code>users</code>.
    DESC

    let :type do
      "users"
    end

    parameter "username", <<-DESC, scope: :attributes
      The unique identifier for the user.
    DESC

    let "username" do
      "seand"
    end

    parameter "password", <<-DESC, scope: :attributes
      The password with which the user with authenticate.
    DESC

    let "password" do
      "!drowssap"
    end

    example_request "PATCH /v1/users/:id" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["data"]["attributes"]["username"]).to eq "seand"
    end
  end

end

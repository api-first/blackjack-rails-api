require "api_documentation_helper"

RSpec.resource "OAuth Tokens" do
  post "/oauth/token" do
    before do
      @post_body_formatter = RspecApiDocumentation.configuration.post_body_formatter.dup
      RspecApiDocumentation.configuration.post_body_formatter = proc do |params|
        params
      end
    end

    let! :user do
      FactoryGirl.create(:user, username: username, password: password, email: email)
    end

    parameter "grant_type", <<-DESC, required: true
      The OAuth2 grant type. Must be <code>password</code>.
    DESC

    let "grant_type" do
      "password"
    end

    parameter "username", <<-DESC
      The username of the user.
    DESC

    let "username" do
      "sean"
    end

    parameter "email", <<-DESC
      The email of the user.
    DESC

    let "email" do
      "david@example.com"
    end

    parameter "password", <<-DESC, required: true
      The password of the user.
    DESC

    let "password" do
      "drowssap"
    end

    example_request "POST /oauth/token" do
      expect(status).to eq 200
      expect(JSON.parse(response_body)["access_token"]).not_to be_nil
    end

    after do
      RspecApiDocumentation.configuration.post_body_formatter = @post_body_formatter
    end
  end
end

require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json, :combined_text, :html]

  config.docs_dir = Rails.root.join("docs")

  config.request_headers_to_include = ["Content-Type", "Authorization"]

  config.response_headers_to_include = ["Content-Type"]

  config.api_name = "API-First Blackjack API"

  config.curl_headers_to_filter = %w[Host Cookie]

  config.post_body_formatter = proc do |params|
    { data: params }.to_json if params.present?
  end
end

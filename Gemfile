source 'https://rubygems.org'
ruby "2.2.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Use postgresql as the database for Active Record
gem 'pg'

# framework for creating json api compliant server
gem "jsonapi-resources", github: "cerebris/jsonapi-resources", branch: "master"

# web server
gem 'puma'

# password encryption for has_secure_password
gem "bcrypt"

gem "doorkeeper"

gem "pundit"

# row sorting
gem "ranked-model", "~> 0.4.0"

gem "rack-cors", ">= 0.4.0", require: "rack/cors"

group :development, :test do
  # `byebug` anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # speeds up development by keeping application running in the background
  gem 'spring'

  # testing framework
  gem 'rspec-rails', '~> 3.0'

  # fixture replacement library
  gem "factory_girl_rails", "~> 4.5.0"
end

group :development do
  # adds spring commands for rspec so that testing can take advantage
  # of the faster start times that spring provides
  gem 'spring-commands-rspec'
end

group :test do
  # runs after_commit callbacks even with transactional fixtures
  gem "test_after_commit"

  gem "database_cleaner", "~> 1.4.0"
end

group :production do
  gem "rails_12factor"
end

# generate api documentation through rspec acceptance tests
gem "rspec_api_documentation"

# engine for displaying api documentation in pretty single page view
gem "apitome"

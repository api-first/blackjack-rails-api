RSpec.configure do |config|
  default_strategy = :transaction

  config.before(:suite) do
    DatabaseCleaner.strategy = default_strategy
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:clean_with] || default_strategy
    DatabaseCleaner.cleaning do
      example.run
    end
    DatabaseCleaner.strategy = default_strategy
  end
end

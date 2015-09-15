JSONAPI.configure do |config|
  config.always_include_to_one_linkage_data = true
  config.exception_class_whitelist = [Exception]
end

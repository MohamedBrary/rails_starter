RspecApiDocumentation.configure do |config|
  config.format = :json
  config.docs_dir = Pathname('docs/api')
  config.request_headers_to_include = %w(Authorization)
  config.response_headers_to_include = %w()
end

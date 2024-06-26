# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
Rails.application.routes.default_url_options[:host] = 'http://127.0.0.1:3000'

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

module SpaBackend
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:4000'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :patch, :delete, :options]
      end
    end
  end
end

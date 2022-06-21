require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UssdTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.session_store UssdEngine::Session::RedisStore, key: "_session_key"
    config.middleware.delete ActionDispatch::Cookies
    config.middleware.insert_before UssdEngine::Session::RedisStore, UssdEngine::Middleware::RequestId
    config.middleware.insert_before UssdEngine::Middleware::RequestId, UssdEngine::Middleware::NaloProcessor
    config.middleware.use UssdEngine::Middleware::Pagination

    config.after_initialize do
      UssdEngine::Config.logger = Rails.logger
    end
  end
end

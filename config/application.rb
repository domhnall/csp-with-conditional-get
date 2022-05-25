require_relative "boot"
require_relative '../lib/middlewares/remove_unneeded_content_security_policy'

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CspWithConditionalGet
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



    # Uncomment the line below to see the effect or our 304 CSP fix
    # config.middleware.insert_before(ActionDispatch::ContentSecurityPolicy::Middleware, RemoveUnneededContentSecurityPolicy)
  end
end

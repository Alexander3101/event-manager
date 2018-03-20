require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EventManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.timezone = 'Moscow'
    config.i18n.default_locale = :ru
    config.middleware.use I18n::JS::Middleware
    config.assets.unknown_asset_fallback = true

    config.ldap = config_for :ldap if File.exist?('config/ldap.yml')
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

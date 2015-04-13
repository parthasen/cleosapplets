require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AppletWebsite
  class Application < Rails::Application

		#IdentityCache needs to fix serialized attributes for Rails 4.2
		ActiveSupport::Deprecation.silenced = true
    #So url_for works in the mailer
		config.action_mailer.default_url_options = { host: 'localhost:3000' }
		#config.middleware.insert_before "ActionDispatch::Static", "Rack::Cors" do
		config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :methods => [:get, :post, :put, :delete, :options],
          :expose => ['Logged-In-Status','Auth-Token','Main-Api-Header']      
      end
    end


    #So Rails-Api doesn't remove all of the middleware
    config.api_only = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end

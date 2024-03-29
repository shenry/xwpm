require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module X
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Pacific Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false

    # to capture trigram and other Postgres goodness
    # config.active_record.schema_format = :sql
    
    # Test framework
    config.generators.test_framework false

    # autoload lib path
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    config.autoload_paths += %W(#{config.root}/app/models/firms)
    config.autoload_paths += %W(#{config.root}/app/controllers/packaging_components)
    config.autoload_paths += %W(#{config.root}/app/controllers/component_events)
    config.autoload_paths += %W(#{config.root}/app/views/packaging_components)
    config.autoload_paths += %W(#{config.root}/app/models/lib)  
    config.autoload_paths += %W(#{config.root}/app/models/events) 
     

  end
end

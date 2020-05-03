require_relative 'boot'

require "rails"

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JwtVue1
  class Application < Rails::Application
    config.load_defaults 6.0

    config.i18n.default_locale = :ru # не ru_RU
    config.time_zone = "Moscow"
    config.active_record.default_timezone = :utc
    config.active_record.time_zone_aware_attributes = false

    config.api_only = false

    # API: http://edgeguides.rubyonrails.org/configuring.html#configuring-generators
    # Разъяснение http://rusrails.ru/configuring-rails-applications
    config.generators do |g|
      g.assets false
      g.channel assets: false
      g.controller_specs false
      g.factory_bot true
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.helper false
      g.helper_specs false
      g.stylesheets false
      g.system_tests false
      g.view_specs false
      g.test_framework :rspec, fixtures: false, view_specs: false, helper_specs: false, routing_specs: false, controller_specs: false, request_specs: false
    end
  end
end

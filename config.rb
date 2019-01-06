# frozen_string_literal: true

module Compliance
  class Configuration
    attr_accessor :api_url, :api_token, :queries_path, :serializers_path,
                  :server_port, :app_env, :app_version, :server_ip
  end
  class << self
    attr_writer :configuration
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
      configuration
    end
  end
end

CONFIG = Compliance.configure do |config|
  config.app_version      = '0.0.1'
  config.api_url          = 'https://api.github.com/graphql'
  config.api_token        = ENV['GITHUB_TOKEN'] || '1c137e3e7eed075a3d036e230df6397bbe9ff865' # rubocop:disable Metrics/LineLength
  config.app_env          = ENV['APP_ENV'] || 'development'
  config.queries_path     = './queries'
  config.serializers_path = './serializers'
  config.server_port      = 4000
  config.server_ip        = '0.0.0.0'
end

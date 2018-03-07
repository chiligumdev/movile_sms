require 'figaro'
# lib/movile.rb
module Movile
  # lib/movile/sms_helper.rb
  class SmsHelper
    def initialize
      load_env_variables
    end

    def base_api_url
      'https://api-messaging.movile.com/v1/send-sms'.freeze
    end

    def report_api_url
      'https://api-messaging.movile.com/v1/sms-status?id='.freeze
    end

    def bulk_api_url
      'https://api-messaging.movile.com/v1/send-bulk-sms'.freeze
    end

    protected

    def load_env_variables
      Figaro.application = Figaro::Application.new(path: 'config/application.yml')
      Figaro.load
    end
  end
end

require "movile_sms/version"
require "movile_sms/sms"

require 'faraday'
require 'json'

API_URL = "https://api-messaging.movile.com/v1/send-sms"

module MovileSms

  class Sms

    attr_reader :username, :access_token

    def initialize(attributes)
      @username     = attributes["username"]
      @access_token = attributes["access_token"]
    end

    def self.get_user
    end
  end

end

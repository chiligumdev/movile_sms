require "movile_sms/version"
require "movile_sms/sms"

require 'httparty'
require 'json'

API_URL = "https://api-messaging.movile.com/v1/send-sms"

module MovileSms

  class Sms

    attr_reader :username, :access_token, :phone_number, :message

    def initialize(attributes)
      @username     = attributes["username"]
      @access_token = attributes["access_token"]
      @phone_number = attribute["phone_number"]
      @message      = attribute["message"]
    end

    def self.send_sms
    end
  end

end

require 'byebug'

class Sms

  BASE_API_URL = "https://api-messaging.movile.com/v1/send-sms"

  attr_reader :username, :access_token, :phone_number, :message

  def initialize(attributes)
    @options = { query: { UserName: attributes["username"],
                          AuthenticationToken: attributes["access_token"],
                          destination: attributes["phone_number"],
                          messageText: attributes["message"] }
               }
  end

  def self.send_message
    response = HTTParty.post(BASE_API_URL, @options)
  end

end
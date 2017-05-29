require 'byebug'

class Sms

  BASE_API_URL = "https://api-messaging.movile.com/v1/send-sms"

  def initialize(attributes)
    @options = { UserName: attributes["username"],
                 AuthenticationToken: attributes["access_token"],
                 destination: attributes["phone_number"],
                 messageText: attributes["message"]
               }
  end

  def send_message
    response = HTTParty.post(BASE_API_URL, @options)
  end

end
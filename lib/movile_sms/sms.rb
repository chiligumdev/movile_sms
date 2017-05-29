require 'byebug'

class Sms
  include HTTParty

  BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'

  def initialize(attributes)
    @options = { 'UserName' => attributes[:username], 'AuthenticationToken' => attributes[:access_token], 'Content-Type' => 'application/json' }
  end

  def send_message(number, text)
    body = { "destination" => number.to_s, "messageText" => text.to_s }.to_json
    response = self.class.post(BASE_API_URL, headers: @options, body: body )
  end

end
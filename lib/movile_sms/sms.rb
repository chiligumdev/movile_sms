#require 'byebug'

class Sms
  include HTTParty

  BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'

  def initialize(attributes)
    @options = { 'UserName' => attributes[:username], 'AuthenticationToken' => attributes[:access_token], 'Content-Type' => 'application/json' }
  end

  def send_message(number, text)
    if valid_number?(number) and text_size(text)
      body = { "destination" => number.to_s, "messageText" => text.to_s }.to_json
      response = self.class.post(BASE_API_URL, headers: @options, body: body )
    else
      raise "Check if the imputed number #{number} is valid or if the text has a maximum of 162 characters
"
    end
  end

  def valid_number?(number)
    true if Float(number) rescue false
  end

  def text_size(text)
    text.size <= 162
  end

end
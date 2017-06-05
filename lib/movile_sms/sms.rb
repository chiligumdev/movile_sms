# lib/movile_sms/sms.rb
class Sms
  include HTTParty

  BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'.freeze

  def initialize(attributes)
    @options = {}
    @options['UserName'] = attributes[:username]
    @options['AuthenticationToken'] = attributes[:access_token]
    @options['Content-Type'] = 'application/json'
  end

  def send_message(number, text)
    raise 'Not Valid' if valid_number?(number) && text_size(text)
    body = { 'destination' => number, 'messageText' => text }.to_json
    self.class.post(BASE_API_URL, headers: @options, body: body)
  end

  def valid_number?(number)
    Float(number)
  end

  def text_size(text)
    text.size <= 162
  end
end

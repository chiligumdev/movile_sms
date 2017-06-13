# lib/movile/sms.rb
class SMS
  include HTTParty

  BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'.freeze

  REPORT_API_URL = 'https://api-messaging.movile.com/v1/sms-status?id='.freeze

  def initialize(attributes)
    @options = {}
    @options['UserName'] = attributes[:username]
    @options['AuthenticationToken'] = attributes[:access_token]
    @options['Content-Type'] = 'application/json'
  end

  def send_message(number, text)
    raise 'Not Valid' unless numeric?(number) && valid_text?(text)
    body = { 'destination' => number, 'messageText' => text }.to_json
    response = self.class.post(BASE_API_URL, headers: @options, body: body)
    response['id']
  end

  def status_message(uuid)
    response = self.class.get(REPORT_API_URL + uuid, headers: @options)
    JSON.parse(response.body)
  end

  # Return false if the value isn't a numeric value
  def numeric?(number)
    Float(number) ? true : false
  end

  def valid_text?(text)
    text.size <= 160
  end
end
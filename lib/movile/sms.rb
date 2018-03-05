require 'figaro'
# lib/movile
module Movile
  # lib/movile/sms.rb
  class SMS
    include HTTParty

    BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'.freeze
    REPORT_API_URL = 'https://api-messaging.movile.com/v1/sms-status?id='.freeze
    BULK_API_URL = 'https://api-messaging.movile.com/v1/send-bulk-sms'.freeze

    def initialize(attributes)
      load_env_variables
      @options = {}
      @options['UserName'] = attributes[:username]
      @options['AuthenticationToken'] = attributes[:authentication_token]
      @options['Content-Type'] = 'application/json'
    end

    def send_message(number, text)
      if valid_message?(number, text)
        body = { 'destination' => number, 'messageText' => text }.to_json
        response = self.class.post(BASE_API_URL, headers: @options, body: body)
        response['id']
      else
        valid_number?(number) ? "The text message has #{text.size} characters the limit is 160." : "The phone number #{number} its not valid"
      end
    end

    def status_message(uuid)
      response = self.class.get(REPORT_API_URL + uuid, headers: @options)
      JSON.parse(response.body)
    end

    # Return false if the value isn't a numeric value
    # The double negation turns this into an actual boolean true
    def valid_number?(number)
      result = number =~ /\A[+]?[0-9]*\.?[0-9]+\z/
      return false if result.nil?

      result = number.gsub(/\D+/, "")
      return result.size == 13 || result.size == 12
    end

    def valid_text?(message)
      return false if message.nil?
      message.size <= 160
    end

    def valid_message?(number, message)
      valid_number?(number) && valid_text?(message)
    end

    protected

    # Config to load application file figaro and env variables
    def load_env_variables
      Figaro.application = Figaro::Application.new(path: "config/application.yml")
      Figaro.load
    end
  end
end

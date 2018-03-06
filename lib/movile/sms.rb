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
        valid_number?(number) ? error_text_message(text) : error_message_number(number)
      end
    end

    def status_message(uuid)
      response = self.class.get(REPORT_API_URL + uuid, headers: @options)
      JSON.parse(response.body)
    end

    def self.generate_cell_phone
      "+55#{'%07d' % rand(10**7)}#{'%04d' % rand(10**4)}"
    end

    private

    def error_message_number(number)
      'The phone number #{number} its not valid'
    end

    def error_text_message(text)
      'The text message has #{text.size}. Enter at least 1 character or at most 160 characters.'
    end

    def valid_number?(number)
      result = number =~ /\A[+]?[0-9]*\.?[0-9]+\z/
      return false if result.nil?

      result = number.gsub(/\D+/, '')
      result.size == 13 || result.size == 12
    end

    def valid_text?(message)
      return false if message.empty?
      message.size <= 160
    end

    def valid_message?(number, message)
      number = number.to_s
      valid_number?(number) && valid_text?(message)
    end

    protected

    # Config to load application file figaro and env variables
    def load_env_variables
      Figaro.application = Figaro::Application.new(path: 'config/application.yml')
      Figaro.load
    end
  end
end

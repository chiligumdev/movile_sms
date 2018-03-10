require 'byebug'
# lib/movile
module Movile
  # lib/movile/sms.rb
  class SMS < Movile::SmsHelper
    include HTTParty

    def initialize(attributes)
      super
      @options['UserName'] = attributes[:username]
      @options['AuthenticationToken'] = attributes[:authentication_token]
    end

    def send_message(number, text)
      if valid_message?(number, text)
        body = { 'destination' => number, 'messageText' => text }.to_json
        response = self.class.post(base_api_url, headers: @options, body: body)
        response['id']
      else
        valid_number?(number) ? error_message(text) : error_number(number)
      end
    end

    def status_message(uuid)
      response = self.class.get(report_api_url + uuid, headers: @options)
      JSON.parse(response.body)
    end

    def self.generate_cell_phone
      "+55#{sprintf(rand(10**7).to_s)}#{sprintf(rand(10**4).to_s)}"
    end

    def error_number(number)
      "The phone number #{number} its not valid"
    end

    def error_message(text)
      "The text message has #{text.size}
      . Enter at least 1 character or at most 160 characters."
    end

    private

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
  end
end

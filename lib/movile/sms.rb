# lib/movile
module Movile
  # lib/movile/sms.rb
  class SMS
    include HTTParty

    BASE_API_URL = 'https://api-messaging.movile.com/v1/send-sms'.freeze

    REPORT_API_URL = 'https://api-messaging.movile.com/v1/sms-status?id='.freeze

    BULK_API_URL = 'https://api-messaging.movile.com/v1/send-bulk-sms'.freeze

    def initialize(attributes)
      @options = {}
      @options['UserName'] = attributes[:username]
      @options['AuthenticationToken'] = attributes[:access_token]
      @options['Content-Type'] = 'application/json'
    end

    def send_message(number, text)
      if valid_message?(number, text)
        body = { 'destination' => number, 'messageText' => text }.to_json
        response = self.class.post(BASE_API_URL, headers: @options, body: body)
        response['id']
      else
        numeric?(number) ? "The text message has #{text.size} characters the limit is 160." : "The phone number #{number} its not valid"
      end
    end

    def send_bulk_message(list_numbers, text, default_message = 'Message')
      body = {}
      messages = []
      list_numbers.each do |number|
        if valid_message?(number, text)
          messages << { destination: number, messageText: text }
        else
          numeric?(number) ? "The text message has #{text.size} characters the limit is 160." : "The phone number #{number} its not valid"
        end
      end
      body[:messages] = messages
      body[:defaultValues] = { messageText: default_message }
      response = self.class.post(BULK_API_URL, headers: @options, body: body.to_json)
      response['id']
    end

    def status_message(uuid)
      response = self.class.get(REPORT_API_URL + uuid, headers: @options)
      JSON.parse(response.body)
    end

    # Return false if the value isn't a numeric value
    # The double negation turns this into an actual boolean true
    def numeric?(number)
      Float(number) rescue false
    end

    def valid_text?(text)
      text.size <= 160
    end

    def valid_message?(number, text)
      numeric?(number) && valid_text?(text)
    end
  end
end

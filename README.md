# MovileSms

Movile SMS is a gem so you can send sms through the Movile API. It's simple and easy to integrate and start sending your messages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'movile_sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install movile_sms

## Usage

After installing the gem and registering with the movile API, instantiate the Sms class by passing its UserName and AuthenticationToken credentials.

```ruby
  sms =  Movile::SMS.new(username: 'Your User Name', authentication_token: 'Your Authentication Token')

```

After instantiating the Sms class by passing the authentication parameters, call the send_message method by passing the number and text parameters.

Ps: It is mandatory to pass the country and state code before the number.

```ruby
  sms.send_message('5511999999999', 'this is my message from movile_sms gem!')

```

To check the status of your message, you will need to invoke the status_message (uuid) method, passing the uuid returned in the send_message send method.

```ruby
  sms.status_message('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')

```

The following return must be displayed if the uuid is valid.

```json
{
  "id":"f9c100ff-aed0-4456-898c-e57d754c439c",
  "correlationId":"client-id",
  "carrierId":1,
  "carrierName":"VIVO",
  "destination":"5511900009999",
  "sentStatusCode":2,
  "sentStatus":"SENT_SUCCESS",
  "sentAt":1266660300000,
  "sentDate":"2010-02-20T10:05:00Z",
  "campaignId":"64",
  "extraInfo":"",
}
```
You can also send bulk messages with optional defalt texts.
To choose this alternative, you can use the send_bulk_message method available in gem as in the example below.

```ruby
  sms.send_bulk_message(['5511999999999', 5511888888888], 'custom message text')

```

This method has the optional text parameters to make messages with standard texts, your signature is displayed as follows.

```ruby
  def send_bulk_message(list_numbers, text = nil, default_message = 'Message Default')
    some code here...
  end

```

After send a bulk message, the following return must be displayed if the uuid is valid.
```json
{
  "total": 1,
  "start": "2016-09-04T11:12:41Z",
  "end": "2016-09-08T11:17:39.113Z",
  "messages": [
    {
      "id": "25950050-7362-11e6-be62-001b7843e7d4",
      "subAccount": "iFoodMarketing",
      "campaignAlias": "iFoodPromo",
      "carrierId": 1,
      "carrierName": "VIVO",
      "source": "5516981562820",
      "shortCode": "28128",
      "messageText": "Eu quero pizza",
      "receivedAt": 1473088405588,
      "receivedDate": "2016-09-05T12:13:25Z",
      "mt": {
        "id": "8be584fd-2554-439b-9ba9-aab507278992",
        "correlationId": "1876",
        "username": "iFoodCS",
        "email": "customer.support@ifood.com"
      }
    },
    {
      "id": "d3afc42a-1fd9-49ff-8b8b-34299c070ef3",
      "subAccount": "iFoodMarketing",
      "campaignAlias": "iFoodPromo",
      "carrierId": 5,
      "carrierName": "TIM",
      "source": "5519987565020",
      "shortCode": "28128",
      "messageText": "Meu hamburguer está chegando?",
      "receivedAt": 1473088405588,
      "receivedDate": "2016-09-05T12:13:25Z",
      "mt": {
        "id": "302db832-3527-4e3c-b57b-6a481644d88b",
        "correlationId": "1893",
        "username": "iFoodCS",
        "email": "customer.support@ifood.com"
      }
    }
  ]
}
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chiligumdev/movile_sms.


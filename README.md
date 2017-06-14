[![Dependency Status](http://img.shields.io/gemnasium/chiligumdev/movile_sms.svg?style=flat-square)](https://gemnasium.com/chiligumdev/movile_sms)
[![Code Climate](http://img.shields.io/codeclimate/github/chiligumdev/movile_sms.svg?style=flat-square)](https://codeclimate.com/github/chiligumdev/movile_sms)
[![Gem Version](http://img.shields.io/gem/v/movile_sms.svg?style=flat-square)](https://rubygems.org/gems/movile_sms)


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

```
  sms =  SMS.new(username: 'Your User Name', access_token: 'Your Access Token')

```

After instantiating the Sms class by passing the authentication parameters, call the send_message method by passing the number and text parameters.

Ps: It is mandatory to pass the country and state code before the number.

```
  sms.send_message('5511999999999', 'this is my message from movile_sms gem!')

```

To check the status of your message, you will need to invoke the status_message (uuid) method, passing the uuid returned in the send_message send method.

```
  sms.status_message('xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx')

```

The following return must be displayed if the uuid is valid.

```
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



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chiligumdev/movile_sms.


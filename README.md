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
  sms =  Movile::SMS.new(username: 'Your User Name', access_token: 'Your Access Token')

```

After instantiating the Sms class by passing the authentication parameters, call the send_message method by passing the number and text parameters.

Ps: It is mandatory to pass the country and state code before the number.

```
  sms.send_message('5511999999999', 'this is my message from movile_sms gem!')

```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/chiligumdev/movile_sms.


# Cardreader
Detect a business card information using Google Cloud Vison API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cardreader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cardreader

## Usage
Prepare a business card.  
![A Business Card Sample](https://raw.githubusercontent.com/alpha-netzilla/cardreader/master/example/card.png "card")


Set you API key for Google Cloud and use detect method with an argument of a picture.
```ruby
manage = Cardreader::Manage.new (
  key = "******"  # Google Cloud Vison API key
)

manage.detect("example/card.jpg")
```

Returned JSON
```
{
  "person": "Shinya Funaki",
  "organization": " Technology Planning Department",
  "location": " Higashi-Shimbashi Minato-Ku Tokyo",
  "mail": "alpha.netzilla@gmail.com",
  "url": "http://example.com/",
  "phone": "+81-80-xxxx-xxxx",
  "company": "Example"
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alpha-netzilla/cardreader. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


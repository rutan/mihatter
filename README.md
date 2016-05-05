# Mihatter

Mihatter is a simple Twitter crawler.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mihatter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mihatter

## Usage

```ruby
require 'mihatter'

Mihatter.configuration do |config|
  config.consumer_key = '.....'
  config.consumer_secret = '.....'
  config.access_token = '.....'
  config.access_token_secret = '.....'

  config.keyword = 'sushi'
end

# use REST API
watcher = Mihatter::RestWatcher.new
watcher.run! do |tweet|
  puts tweet.text
end

# use Streaming API (only English, cannot use CJK)
watcher = Mihatter::StreamingWatcher.new
watcher.run! do |tweet|
  puts tweet.text
end
```

## License
MIT

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rutan/mihatter.

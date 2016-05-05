require 'twitter'

module Mihatter
  class StreamingWatcher
    def initialize(config = {})
      @config = Mihatter.configuration.dup.merge(config)
    end

    attr_reader :config

    def run!
      raise ArgumentError, '`Mihatter::StreamingWatcher#run!` require block' unless block_given?
      connect
      @client.filter(track: @config.keyword) do |obj|
        yield obj if obj.is_a?(Twitter::Tweet)
      end
    end

    private

    def connect
      @client = Twitter::Streaming::Client.new do |config|
        config.consumer_key = @config.consumer_key
        config.consumer_secret = @config.consumer_secret
        config.access_token = @config.access_token
        config.access_token_secret = @config.access_token_secret
      end
    end
  end
end

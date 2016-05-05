require 'twitter'

module Mihatter
  class RestWatcher
    def initialize(config = {})
      @config = Mihatter.configuration.dup.merge(config)
    end

    attr_reader :config

    def run!
      raise ArgumentError, '`Mihatter::RestWatcher#run!` require block' unless block_given?

      begin
        connect
        assign_since_id unless @config.since_id
        loop do
          search.each do |tweet|
            yield tweet
            @config.since_id = tweet.id
          end
          sleep @config.wait_time
        end
      rescue Twitter::Error::TooManyRequests => e
        sleep e.rate_limit.reset_in
      end
    end

    def since_id
      @config.since_id
    end

    private

    def connect
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key = @config.consumer_key
        config.consumer_secret = @config.consumer_secret
        config.access_token = @config.access_token
        config.access_token_secret = @config.access_token_secret
      end
    end

    def assign_since_id
      result = @client.search(@config.keyword, {
        result_type: 'recent',
        count: 1,
        lang: @config.lang,
      }.delete_if { |_, v| v.nil? }).first
      @config.since_id = (result ? result.id : 0)
    end

    def search(max_id: nil)
      results = @client.search(@config.keyword, {
        result_type: 'recent',
        count: 100,
        lang: @config.lang,
        max_id: max_id,
        since_id: @config.since_id,
      }.delete_if {|_, v| v.nil?} ).take(100).sort do |a, b|
        a.id <=> b.id
      end
      results = search(max_id: results.first.id - 1) + results if results.size == 100
      results
    end
  end
end

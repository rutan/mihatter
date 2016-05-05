module Mihatter
  class Configuration
    def initialize
      self.keyword = 'Twitter'
      self.wait_time = 30
    end

    attr_accessor :consumer_key
    attr_accessor :consumer_secret
    attr_accessor :access_token
    attr_accessor :access_token_secret

    attr_accessor :keyword
    attr_accessor :lang
    attr_accessor :since_id

    attr_accessor :wait_time

    def merge(config = {})
      config.each { |k, v| self.public_send("#{k}=", v) }
      self
    end
  end
end

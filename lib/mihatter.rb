require 'mihatter/version'
require 'mihatter/configuration'
require 'mihatter/rest_watcher'
require 'mihatter/streaming_watcher'

module Mihatter
  def self.configuration
    @configuration ||= Mihatter::Configuration.new
    yield @configuration if block_given?
    @configuration
  end
end

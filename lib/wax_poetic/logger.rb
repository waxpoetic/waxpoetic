require 'active_support/logger'
require 'active_support/tagged_logging'

module WaxPoetic
  # A logger class for the entire application. We log to STDOUT to aid
  # in development, but it also helps us when we log to `syslog` in
  # production to provide a single logging interface for every message
  # the app, jobs or services send.
  class Logger
    attr_reader :logger, :tags

    # Optionally initialize the Logger object with a tag, so that all
    # log messages are prepended with that tag string.
    def initialize(tags: nil)
      @tags = tags || []
      @base = ActiveSupport::Logger.new(STDOUT)
      @logger = ActiveSupport::TaggedLogging.new @base
    end

    # Delegate all method calls to the internal logger object, but
    # prepend log messages with a tag if present.
    def method_missing(method, *arguments)
      return super unless respond_to? method

      if tags.any?
        logger.tagged tags do
          logger.send method, *arguments
        end
      else
        logger.send method, *arguments
      end
    end

    # Any method that the underlying Logger object responds to can be
    # called on this class as well.
    def respond_to?(method)
      logger.respond_to?(method) || super
    end
  end
end

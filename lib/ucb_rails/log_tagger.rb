# Wraps another logger and tags output.
class LogTagger
  LOGGER_METHODS = [:debug, :error, :fatal, :info, :unknown, :warn]
  
  attr_accessor :tag, :logger
  
  def initialize(tag, logger)
    self.tag = tag
    self.logger = logger
  end
  
  def method_missing(method, *args)
    if LOGGER_METHODS.include?(method)
      logger.send(method, "[#{tag}] #{args.first}")
    else
      super
    end
  end

end
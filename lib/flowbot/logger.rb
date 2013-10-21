require 'logging'

module Flowbot
  module Logger
    def self.logger
      log = Logging.logger['flowbot_logger']
      log.add_appenders(
        Logging.appenders.stdout,
        Logging.appenders.file('log/flowbot.log')
      )
      log.level = :info
      log
    end
  end
end

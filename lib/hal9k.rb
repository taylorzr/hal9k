require 'hal9k/version'
require 'hal9k/flag'
require 'hal9k/flags'
require 'hal9k/command'
require 'hal9k/commands'
require 'hal9k/root'

# TODO Need to exclude spec if sticking with pattern of spec next to
# unit
# Dir.glob(File.join(__dir__, 'directory', '**', '*.rb')).each { |file| require file }

module Hal9k
  class << self
    attr_accessor :root

    def start(root, argv = ARGV)
      # TODO: raise helpful error if no commands, or no commands match
      # TODO: maybe show help instead but exit with 1 status
      translate(root, argv).call
    end

    def translate(root, argv)
      result = Hal9k::Commands.parse(root, argv)

      argv          = result[:argv]
      command       = result[:command]
      command_names = result[:command_names]

      result = Hal9k::Flags.parse(argv, command.flags)

      arguments = result[:arguments]
      flags     = result[:flags]

      command.new(arguments, flags, command_names)
    end
  end
end

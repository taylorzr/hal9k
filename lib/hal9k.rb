require 'hal9k/version'
require 'hal9k/arguments'
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
      command, arguments = translate(root, argv)

      command.call(*arguments)
    end

    def translate(root, argv)
      command, argv, path = Hal9k::Commands.parse(root, argv)

      arguments, flags = Hal9k::Flags.parse(argv, command.flags)

      # unless Hal9k::Arguments.valid?(command, arguments)
      #   raise StandardError, 'Arguments not valid'
      # end

      [command.new(flags, path), arguments]
    end
  end
end

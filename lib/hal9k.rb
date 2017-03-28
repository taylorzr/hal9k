require 'hal9k/version'
require 'hal9k/argument'
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

    def translate(root, argv)
      command, argv, path = Hal9k::Commands.parse(root, argv)

      argv, flags = Hal9k::Flags.parse(argv, command.hal9k_flags)

      arguments = Hal9k::Arguments.parse(argv, command.hal9k_arguments)

      command.new(arguments, flags, path)
    end
  end
end

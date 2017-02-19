module Hal9k
  class Command
    class << self
      # HELP MENU STUFF
      def use; end
      def short; end
      def long; end

      # TODO: Better naming?!?!?
      def command(name)
        Hal9k::Commands.register(name, self)
      end

      def flag(long, short = nil, type: String, default: nil, scope: :local)
        flag = type.new(short: short, long: long, default: default)
        flags << flag
        flag
      end

      def run; end

      def flags
        @flags ||= []
      end
    end

    def call
    end

    attr_reader :arguments, :flags

    # TODO: Add command path
    def initialize(arguments, flags, command_names)
      @arguments     = arguments
      @flags         = flags
      @command_names = command_names
    end
  end
end

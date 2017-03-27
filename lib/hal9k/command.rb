require 'active_support/core_ext/string'

module Hal9k
  class Command
    class << self
      # HELP MENU STUFF
      def use; end
      def short; end
      def long; end

      def mount(at)
        if at == :hal9k_root
          Hal9k.root = self
        else
          self.supercommand = at
          at.subcommands << self
        end
      end

      def argument(name, type: Hal9k::String)
        argument = Argument.new(name, type: type)
        arguments << argument
        argument
      end

      def flag(long, short = nil, type: String, default: nil, local: false)
        flag = type.new(short: short, long: long, default: default)
        flags << flag
        flag
      end

      def run; end

      def endpoint
        @endpoint ||= name.demodulize.underscore
      end

      def subcommands
        @subcommands ||= []
      end

      def arguments
        @arguments ||= []
      end

      def flags
        # NOTE: How should we handle over-writing flags
        @flags ||= superflags
      end

      def root
        :hal9k_root
      end

      def start(argv = ARGV)
        Hal9k.start(self, argv)
      end

      private

      attr_accessor :supercommand

      def superflags
        # TODO: Get rid of != hal9k check after we set a default root
        # command
        @superflags ||= if supercommand && supercommand != :hal9k
          supercommand.flags
        else
          []
        end
      end
    end

    def call
      raise NotImplementedError
    end

    attr_reader :arguments, :flags, :command_names

    def initialize(arguments, flags, command_names)
      @arguments     = arguments
      @flags         = flags
      @command_names = command_names
    end
  end
end

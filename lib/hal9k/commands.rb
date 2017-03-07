module Hal9k
  class Commands
    class << self
      def mount(command)
        subcommands << command
      end

      def parse(argv)
        # TODO: Root command
        # TODO: Nested commands
        # TODO: Can flags come before some commands?!?
        argv = argv.dup

        command_path = []
        command = subcommands.first

        loop do
          break unless argv.first

          subcommand = command.subcommands.find do |subcommand|
            subcommand.endpoint.include? argv.first
          end

          break unless subcommand

          command = subcommand
          command_path << argv.shift
        end

        {
          command_names: command_path,
          argv:          argv,
          command:       command
        }
      end

      private

      def subcommands
        @subcommands ||= []
      end
    end
  end
end

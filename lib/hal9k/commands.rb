module Hal9k
  class Commands
    class << self
      def parse(root_command, argv)
        # TODO: Can flags come before some commands?!?
        argv = argv.dup

        command_path = []
        command = root_command

        loop do
          break unless argv.first

          subcommand = command.subcommands.find do |subcommand|
            subcommand.endpoint.include? argv.first
          end

          break unless subcommand

          command = subcommand
          command_path << argv.shift
        end

        [command, argv, command_path]
      end
    end
  end
end

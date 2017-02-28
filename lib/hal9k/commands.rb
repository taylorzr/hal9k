module Hal9k
  class Commands
    class << self
      def register(name, command)
        commands[name.to_sym] = command
      end

      def parse(argv)
        # TODO: Root command
        # TODO: Nested commands
        # TODO: Can flags come before some commands?!?
        argv = argv.dup

        if commands.key?(argv.first)
          command_name = argv.shift.to_sym
          {
            command_names: [command_name],
            argv:          argv,
            command:       commands[command_name]
          }
        elsif commands.key?(ROOT)
          {
            command_names: [],
            argv:          argv,
            command:       commands[ROOT]
          }
        end
      end

      private

      def commands
        @commands ||= {}
      end
    end
  end
end

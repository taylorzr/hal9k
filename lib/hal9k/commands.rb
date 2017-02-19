module Hal9k
  class Commands
    class << self
      def register(name, command)
        commands[name.to_sym] = command
      end

      def parse(argv)
        # TODO: Nested commands
        # TODO: Can flags come before some commands?!?
        argv = argv.dup
        command_name = argv.shift.to_sym

        if commands.key?(command_name)
          {
            command_names: command_name,
            argv:          argv,
            command:       commands[command_name]
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

module Hal9k
  module Translate
    class << self
      def call(root_command, argv)
        command, argv, path = Commands.parse(root_command, argv)

        argv, flags = Flags.parse(argv, command.hal9k_flags)

        arguments = Arguments.parse(argv, command.hal9k_arguments)

        command.new(arguments, flags, path)
      end
    end
  end
end

module Hal9k
  module Translate
    class << self
      def call(root_command, argv)
        command, argv, path = Commands.parse(root_command, argv)

        result = Flags.parse(argv, command.hal9k_flags)
        # TODO: validate all the required flags were found
        # Abort and return message and usage

        arguments = Arguments.parse(result[:argv], command.hal9k_arguments)

        command.new(arguments, result[:flags], path)
      end
    end
  end
end

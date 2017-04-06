module Hal9k
  module Translate
    class << self
      def call(root_command, argv)
        command, argv, path = Commands.parse(root_command, argv)

        argv, result = Flags::Parse.call(argv, command.hal9k_flags)

        maybe_abort(result)

        arguments = Arguments.parse(argv, command.hal9k_arguments)

        command.new(arguments, result.options, path)
      end

      private

      def maybe_abort(result)
        if [result.missing_value, result.missing, result.duplicate, result.unknown].any?(&:present?)
          abort 'Error parsing flags'
        end
      end
    end
  end
end

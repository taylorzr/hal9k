module Hal9k
  module Translate
    class << self
      def call(root_command, argv)
        command, argv, path = Commands.parse(root_command, argv)

        argv, result = Flags::Parse.call(argv, command.hal9k_flags)

        # TODO: Don't abort until we try to parse arguments as well
        maybe_abort(result)

        outcome, arguments_result = Arguments.parse(argv, command.hal9k_arguments)

        maybe_abort_arguments(outcome, arguments_result)

        command.new(arguments_result, result.options, path)
      end

      private

      def maybe_abort(result)
        if [result.missing_value, result.missing, result.duplicate, result.unknown].any?(&:present?)
          abort 'Error parsing flags'
        end
      end

      def maybe_abort_arguments(outcome, result)
        abort result if outcome == :fail
      end
    end
  end
end

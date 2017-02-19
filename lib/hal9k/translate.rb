module Hal9k
  class Translate
    class << self
      def call(argv)
        result = Hal9k::Commands.parse(argv)

        argv          = result[:argv]
        command       = result[:command]
        command_names = result[:command_names]

        result = Hal9k::Flags.parse(argv, command.flags)

        arguments = result[:arguments]
        flags     = result[:flags]

        command.new(arguments, flags, command_names)
      end
    end
  end
end

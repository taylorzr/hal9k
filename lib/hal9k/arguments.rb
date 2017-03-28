module Hal9k
  module Arguments
    class << self
      def parse(argv, arguments)
        paired_arguments = pair(argv, arguments)

        paired_arguments.map do |arg, argument|
          argument.parse(arg)
        end
      end

      private

      def pair(argv, arguments)
        paired_arguments = []

        # TODO: Handle a mix of count & *, and guard against misuse
        arguments.each do |argument|
          if argument.count == :*
            argv.each do |arg|
              paired_arguments << [arg, argument]
            end
          else
            argument.count.times do
              paired_arguments << [argv.shift, argument]
            end
          end
        end

        paired_arguments
      end
    end
  end
end

module Hal9k
  module Arguments
    class << self
      def parse(argv, arguments)
        paired_arguments = pair(argv, arguments)

        missing_arguments = paired_arguments.select do |value, argument|
          value.nil?
        end

        if missing_arguments.present?
          missing_argument_list = missing_arguments.map(&:last).map(&:name).join(', ')

          return [:fail, "Missing argument(s): #{missing_argument_list}"]
        end

        values = paired_arguments.map do |arg, argument|
          argument.parse(arg)
        end

        [:ok, values]
      end

      private

      def pair(argv, arguments)
        paired_arguments = []

        # TODO: Guard against single argument after splat, or another
        # splat after splat
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

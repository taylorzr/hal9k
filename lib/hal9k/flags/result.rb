module Hal9k
  module Flags
    class Result
      attr_reader :flags, :options, :found, :missing_value, :unknown

      def initialize(flags)
        @flags         = flags
        @options       = defaults
        @found         = []
        # TODO: Maybe make an option class so that we can compute
        # missing value and found after the fact, instead of within parse
        # something like Option.new(value, flag)
        @missing_value = []
        @unknown       = []
      end

      def add_option(matching_flag, value)
        found << matching_flag
        options.merge!(matching_flag.long => value)
      end

      def add_unknown(segment)
        unknown << segment
      end

      def add_missing_value(segment)
        missing_value << segment
      end

      def missing
        required - found
      end

      def duplicate
        found
          .group_by { |item| item }
          .select { |key, value| value.count > 1 }.keys
      end

      private

      def required
        flags.select(&:requires_value?)
      end

      def defaults
        Hash[
          flags.select(&:default?).map do |flag|
            [flag.long, flag.default]
          end
        ]
      end
    end
  end
end

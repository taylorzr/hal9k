module Hal9k
  module Flags
    class Result
      attr_reader :flags, :options, :found, :duplicate, :missing, :missing_value, :unknown

      def initialize(flags)
        @flags         = flags
        @options       = defaults
        @found         = []
        @duplicate     = []
        @missing_value = []
        @unknown       = []
      end

      def add_flag(matching_flag, value)
        found << matching_flag
        options.merge!(matching_flag.long => value)
      end

      def add_unknown(segment)
        unknown << segment
      end

      def add_missing_value(segment)
        missing_value << segment
      end

      def add_duplicate(flag)
        duplicate << flag
      end

      def missing
        required - found
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

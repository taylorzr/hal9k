module Hal9k
  module Flags
    class Result
      attr_reader :flags, :found, :unknown, :missing_value, :duplicate

      def initialize(defaults)
        @flags         = defaults
        @found         = []
        @unknown       = []
        @missing_value = []
        @duplicate     = []
      end

      def add_flag(matching_flag, value)
        found << matching_flag
        flags.merge!(matching_flag.long => value)
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
    end
  end
end

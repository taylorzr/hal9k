# TODO: require glob
require_relative 'flags/boolean'
require_relative 'flags/string'

module Hal9k
  module Flags
    class << self
      def parse(argv, flags)
        # TODO:
        # expand_short_flag_groups
        
        # TODO:
        # Invert default value for boolean when short flag present

        result = {
          arguments: [],
          flags:     defaults_for(flags)
        }

        until argv.empty?
          if Flag.flag_string?(argv.first)
            # TODO: Convert to not mutate
            flag = parse_flag(argv, flags)
            result[:flags].merge!(flag)
          else
            result[:arguments] << argv.shift
          end
        end

        result
      end

      private

      def defaults_for(flags)
        Hash[
          flags.select(&:default?).map do |flag|
            [flag.long, flag.default]
          end
        ]
      end

      # def expand_short_flag_groups
      #   self.segments = segments.map do |segment|
      #     if segment.short_flag?
      #       segment.split
      #     else
      #       segment
      #     end
      #   end.flatten
      # end

      def parse_flag(argv, flags)
        # Get first segment
        # If it starts with -/--
        #   Match it to a flag
        #   if doesn't match
        #     Error flag mismatch
        #   else
        #     set flags long value as key
        #     Match the next segment to a value for the flag
        #     if it matches
        #       coerce to type and set as value
        #     else
        #       Error if a value is required for the flag
        #     end
        #   end
        # end
        segment = argv.shift

        matching_flag = flags.find { |flag| flag.matches?(segment) }

        raise StandardError, "No matching flag for #{segment}" unless matching_flag

        key = matching_flag.long

        if argv.first && matching_flag.matching_value?(argv.first)
          value_segment = argv.shift
          value = matching_flag.coerce(value_segment)
        else
          raise StandardError, "No value provided for #{segment}" unless matching_flag.default?
          value = matching_flag.default
        end

        { key => value }
      end
    end
  end
end

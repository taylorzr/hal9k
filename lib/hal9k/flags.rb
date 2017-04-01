require_relative 'types'

module Hal9k
  module Flags
    class << self
      def parse(argv, flags)
        # TODO:
        # expand_short_flag_groups

        # TODO:
        # Invert default value for boolean when short flag present

        # TODO: Maybe create a result object
        result = {
          flags: defaults_for(flags),
          argv:  [],
          found: [],
          errors: {
            unknown:       [],
            missing_value: [],
            duplicate:     []
          }
        }

        until argv.empty?
          if Flag.flag_string?(argv.first)
            argv = extract(argv, flags, result)
          else
            segment, *argv = *argv
            result[:argv] << segment
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

      def extract(argv, flags, result)
        flag_segment, *argv = *argv

        matching_flag = flags.find { |flag| flag.matches?(flag_segment) }

        unless matching_flag
          result[:errors][:unknown] << flag_segment
          return argv
        end

        if result[:found].include?(matching_flag)
          result[:errors][:duplicate] << matching_flag
        else
          result[:found] << matching_flag
        end

        has_value = argv.first && !Flag.flag_string?(argv.first) && matching_flag.type.matching_value?(argv.first)

        if has_value
          value_segment, *argv = *argv
          value = matching_flag.type.coerce(value_segment)
          result[:flags].merge!(matching_flag.long => value)
        else
          if matching_flag.default?
            result[:flags].merge!(matching_flag.long => matching_flag.default)
          else
            result[:errors][:missing_value] << flag_segment
          end
        end

        argv
      end
    end
  end
end

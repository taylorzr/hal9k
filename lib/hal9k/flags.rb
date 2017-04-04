require_relative 'types'
require_relative 'flags/result'

module Hal9k
  module Flags
    class << self
      def parse(argv, flags)
        # TODO:
        # expand_short_flag_groups

        remaining_argv = []
        result = Result.new(flags)

        until argv.empty?
          if Flag.flag_string?(argv.first)
            argv = extract(argv, flags, result)
          else
            segment, *argv = *argv
            remaining_argv << segment
          end
        end

        [remaining_argv, result]
      end

      private

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
          result.add_unknown(flag_segment)
          return argv
        end

        has_value = argv.first && !Flag.flag_string?(argv.first) && matching_flag.type.matching_value?(argv.first)

        if has_value
          value_segment, *argv = *argv
          value = matching_flag.type.coerce(value_segment)
          result.add_option(matching_flag, value)
        else
          if matching_flag.default?
            value = matching_flag.default

            # TODO: This requires a bit more though
            # Should both long and short invert the boolean
            # Long inversion is kinda weird, e.g.
            #   echo --new-line # Englishwise, this reads as yes newline
            # So maybe
            #   echo --no-new-line
            # And only short inverts
            #   echo -n # Equivalent to --no-new-line
            if matching_flag.type == Boolean
              if Flag.short_flag_string?(flag_segment) || (Flag.long_flag_string?(flag_segment) && flag_segment.start_with?('--no'))
                value = !value
              end
            end

            result.add_option(matching_flag, value)
          else
            result.add_missing_value(flag_segment)
          end
        end

        argv
      end
    end
  end
end

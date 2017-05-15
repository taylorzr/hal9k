module Hal9k
  module Flags
    module Parse
      class << self
        def call(argv, flags)
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

          # Handle --flag=value here?

          # if flag includes =
          # split at equals
          # last part is the value
          # now we have the problem that the flag value doesn't match
          # the type

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

              # TODO: This is getting kinda gross, maybe have multiple
              # parsers where we determine the type, and parse
              # appropriately
              #
              # Or maybe we could use currying with the new method on
              # Flag to pass in the flag segment and/or value to more
              # cleanly handle this parsing
              #
              # Or maybe just use another class to do some of this
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

        def extract_flag(argv)
        end
      end
    end
  end
end

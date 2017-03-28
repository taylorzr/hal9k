module Hal9k
  class String
    class << self
      def matching_value?(value)
        true
      end

      def coerce(value)
        value
      end
    end
  end
end

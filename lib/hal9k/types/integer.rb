module Hal9k
  class Integer
    class << self
      def matching_value?(value)
        value.match(/\d+/)
      end

      def coerce(value)
        value.to_i
      end
    end
  end
end

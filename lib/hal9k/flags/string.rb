module Hal9k
  class String < Flag
    def matching_value?(value)
      true
    end

    def coerce(value)
      value
    end
  end
end

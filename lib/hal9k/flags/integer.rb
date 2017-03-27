module Hal9k
  class Integer < Flag
    def matching_value?(value)
      value.match(/\d+/)
    end

    def coerce(value)
      value.to_i
    end
  end
end

module Hal9k
  class Boolean < Flag
    def matching_value?(value)
      value.match(/(true|false)/i)
    end

    def coerce(value)
      case value.downcase
      when 'true'  then true
      when 'false' then false
      else
        raise StandardError, "Unable to coerce #{value.inspect} to Boolean"
      end
    end
  end
end

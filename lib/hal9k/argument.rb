module Hal9k
  class Argument
    def initialize(name, type:)
      @name = name
      @type = type
    end

    def parse(raw)
      # TODO:
      # - match
      # - coerce
      if raw.match(/^\d+$/)
        raw.to_i
      else
        raw
      end
    end
  end
end

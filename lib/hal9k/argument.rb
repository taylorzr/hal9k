module Hal9k
  class Argument
    attr_reader :count

    def initialize(name, type:, count: 1)
      self.name  = name
      self.type  = type
      self.count = count
    end

    def parse(value)
      raise StandardError unless type.matching_value?(value)

      type.coerce(value)
    end

    private

    attr_accessor :name, :type
    attr_writer :count
  end
end

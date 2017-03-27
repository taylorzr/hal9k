module Hal9k
  module Arguments
    class << self
      def parse(argv, arguments)
        argv.map.with_index do |arg, index|
          arguments[index].parse(arg)
        end
      end
    end
  end
end

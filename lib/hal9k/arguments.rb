module Hal9k
  module Arguments
    class << self
      def valid?(command, arguments)
        method = command.instance_method(:call)
        # TODO: Support optional or splat
        arguments.count == method.arity
      end
    end
  end
end

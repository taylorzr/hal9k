require 'active_support/core_ext/string'

module Hal9k
  class Flag
    SHORT_FLAG_REGEXP = /\A-{1}(?!-)/
    LONG_FLAG_REGEXP  = /\A-{2}(?!-)/

    class << self
      def flag_string?(string)
        short_flag_string?(string) || long_flag_string?(string)
      end

      private

      def short_flag_string?(string)
        string.match(SHORT_FLAG_REGEXP)
      end

      def long_flag_string?(string)
        string.match(LONG_FLAG_REGEXP)
      end
    end

    def initialize(short:, long:, default: nil)
      @short   = short
      @long    = long
      @default = default
    end

    attr_reader :short, :long, :default

    def appropriate_value?(_value)
      raise NotImplementedError
    end

    def matches?(flag_string)
      flag_string == short_string || flag_string == long_string
    end

    def default?
      !default.nil?
    end

    def coerce(value)
      raise NotImplementedError
    end

    private

    # TODO: Dasherize short/long
    def short_string
      "-#{short}".dasherize
    end

    def long_string
      "--#{long}".dasherize # TODO: "--no-#{long}"
    end
  end
end

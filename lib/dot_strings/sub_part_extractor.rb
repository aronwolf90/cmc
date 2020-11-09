# frozen_string_literal: true

module DotStrings
  class SubPartExtractor < Base
    attr_reader :dot_strings, :prefix

    def initialize(dot_strings, prefix)
      @dot_strings = dot_strings
      @prefix = prefix
    end

    def call
      return if dot_strings.nil?

      dot_strings.select do |dot_string|
        dot_string.start_with?(prefix)
      end.map do |dot_string|
        dot_string.gsub(/^#{prefix}\.?/, "")
      end
    end
  end
end

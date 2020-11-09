# frozen_string_literal: true

module DotStrings
  class HashConverter < Base
    attr_reader :dot_strings

    def initialize(dot_strings)
      @dot_strings = dot_strings
    end

    def call
      return {} if dot_strings.nil?
      return dot_strings if dot_strings.is_a?(Hash)

      dot_strings.map do |dot_string|
        dot_string.split(".").reverse.reduce({}) do |result, string|
          { string.to_sym => result }
        end
      end.reduce(&:deep_merge)
    end
  end
end

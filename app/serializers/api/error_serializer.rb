# frozen_string_literal: true

module Api
  class ErrorSerializer
    def self.call(tree)
      {
        errors: branches(tree).map do |branch|
          {
            source: { pointer:  branch.flatten[0..-2].join("/") },
            detail:  branch.flatten.last
          }
        end
      }
    end

    def self.branches(tree)
      return [[tree]] unless tree.is_a?(Hash)

      tree.flat_map do |key, value|
        branches(value).map do |result|
          [key] + [result]
        end
      end
    end
  end
end

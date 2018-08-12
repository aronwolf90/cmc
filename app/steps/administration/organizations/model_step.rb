# frozen_string_literal: true

module Administration
  module Organizations
    class ModelStep < ApplicationStep
      def self.call(options, **)
        options[:model] = Organization.current
      end
    end
  end
end

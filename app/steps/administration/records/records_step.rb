# frozen_string_literal: true

module Administration
  module Records
    class RecordsStep < ApplicationStep
      def self.call(options, current_user:, **)
        options[:records] = current_user.records.ordered
      end
    end
  end
end

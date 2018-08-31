# frozen_string_literal: true

module Administration
  module ProjectRecords
    class RecordsStep < ApplicationStep
      def self.call(options, project:, **)
        options[:records] = project.records.ordered
      end
    end
  end
end

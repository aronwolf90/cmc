# frozen_string_literal: true

module Administration
  module ProjectRecords
    class IndexModelStep < ApplicationStep
      def self.call(options, params:, project:, **)
        options["model"] =
          project
            .project_record_days
            .ordered
            .page(params[:page] || 1)
            .per(5)
      end
    end
  end
end

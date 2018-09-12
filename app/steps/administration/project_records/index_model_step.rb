# frozen_string_literal: true

module Administration
  module ProjectRecords
    class IndexModelStep < BaseIndexStep
      def self.call(options, params:, project:, **)
        options["model"] =
          page(project.project_record_days, page: params[:page], per: 5)
      end
    end
  end
end

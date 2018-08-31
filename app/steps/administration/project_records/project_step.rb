# frozen_string_literal: true

module Administration
  module ProjectRecords
    class ProjectStep < ApplicationStep
      def self.call(options, params:, **)
        options[:project] = Project.find(params[:project_id])
      end
    end
  end
end

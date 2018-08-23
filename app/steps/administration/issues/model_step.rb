# frozen_string_literal: true

module Administration
  module Issues
    class ModelStep < ApplicationStep
      def self.call(options, params:, **)
        options[:model] =
          Issue.new(board_list_id: params[:board_list_id])
      end
    end
  end
end

# frozen_string_literal: true

module Administration
  module Issues
    class SetDefaultValueStep < ApplicationStep
      def self.call(options, params:, **)
        options[:model].board_list_id = params[:board_list_id]
      end
    end
  end
end

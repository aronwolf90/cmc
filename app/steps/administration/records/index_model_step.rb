# frozen_string_literal: true

module Administration
  module Records
    class IndexModelStep < ApplicationStep
      def self.call(options, params:, current_user:, **)
        options["model"] =
          current_user
            .record_days
            .ordered
            .page(params[:page] || 1)
            .per(5)
      end
    end
  end
end

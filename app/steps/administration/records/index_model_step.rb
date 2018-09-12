# frozen_string_literal: true

module Administration
  module Records
    class IndexModelStep < BaseIndexStep
      def self.call(options, params:, current_user:, **)
        options["model"] =
          page(current_user.record_days, page: params[:page], per: 5)
      end
    end
  end
end

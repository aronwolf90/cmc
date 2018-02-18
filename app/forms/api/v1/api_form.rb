# frozen_string_literal: true

module Api
  module V1
    class ApiForm
      def self.call(params)
        @form.call(params)
      end
    end
  end
end

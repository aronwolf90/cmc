# frozen_string_literal: true

module Administration
  module Users::Cell
    class Create < ApplicationCell
    private

      def cancel_path
        %i[administration users]
      end
    end
  end
end

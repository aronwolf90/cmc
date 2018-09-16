# frozen_string_literal: true

module Administration
  module Users::Cell
    class Update < ApplicationCell
    private

      def cancel_path
        %i[administration users]
      end
    end
  end
end

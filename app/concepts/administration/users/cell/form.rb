# frozen_string_literal: true

module Administration
  module Users::Cell
    class Form < ApplicationCell
    private

      def cancel_path
        %i[administration users]
      end
    end
  end
end

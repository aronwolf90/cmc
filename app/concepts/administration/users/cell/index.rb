# frozen_string_literal: true

module Administration
  module Users::Cell
    class Index < ApplicationCell
    private

      def new_btn
        link_to "New user", %i[new administration user],
          class: "btn btn-success btn-block"
      end

      def edit_btn(user)
        link_to fa_icon(:edit), [:edit, :administration, :settings, user],
        class: "btn btn-sm btn-secondary"
      end
    end
  end
end

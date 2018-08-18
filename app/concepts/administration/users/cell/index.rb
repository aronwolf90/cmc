# frozen_string_literal: true

module Administration
  module Users::Cell
    class Index < ApplicationCell
    private

      def new_btn
        return unless policy(User).create?
        link_to "New user", new_administration_user_path,
          class: "btn btn-success btn-block"
      end

      def edit_btn(user)
        return unless policy(user).update?
        link_to fa_icon(:edit), edit_administration_settings_user_path(user),
          class: "btn btn-sm btn-secondary"
      end
    end
  end
end

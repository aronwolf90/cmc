# frozen_string_literal: true

module Administration
  module Users::Cell
    class Index < ApplicationCell
    private

      def new_btn
        return unless policy(User).new?
        link_to "New user", new_administration_user_path,
          class: "btn btn-success btn-block"
      end

      def link(user)
        if policy(user).edit?
          link_to user,
            edit_administration_user_path(user),
            class: "text-dark"
        else
          content_tag(:div, class: "text-muted") { user }
        end
      end
    end
  end
end

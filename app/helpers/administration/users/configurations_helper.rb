# frozen_string_literal: true

module Administration
  module Users
    module ConfigurationsHelper
      include AdministrationHelper

      def cancel_btn; end

      def destroy_btn(user)
        return unless policy(user).destroy?

        path = administration_user_configuration_path(user)

        link_to "Destroy", path, method: :delete,
                                 class: "btn btn-destroy"
      end
    end
  end
end

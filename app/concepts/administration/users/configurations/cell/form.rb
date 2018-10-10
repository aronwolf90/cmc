# frozen_string_literal: true

module Administration
  module Users
    module Configurations
      module Cell
        class Form < BaseFormCell
        private
          def actions(form:)
            super(
              form: form,
              destroy_path: administration_user_configuration_path(model.model)
            )
          end

          def destroy_btn(path_array, **options)
            super(path_array, policy: :user, **options)
          end
        end
      end
    end
  end
end

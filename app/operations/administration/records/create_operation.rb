# frozen_string_literal: true

module Administration
  module Records
    class CreateOperation < AdministrationOperation
      @form = RecordForm
      @mutation = ::Records::CreateMutation
      include MvcStandardCreateOperationConcern

      success :set_user, before: "contract.default.validate"

      def set_user(options, current_user:, **)
        options[:params][:data][:user_id] = current_user.id
      end
    end
  end
end

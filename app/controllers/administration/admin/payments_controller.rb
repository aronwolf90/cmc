# frozen_string_literal: true

module Administration
  module Admin
    class PaymentsController < AdministrationController
      side_menu "administration/organization"
      namespace Administration::Admin::Payments

      def index
        run Administration::Admin::Payments::IndexOperation

        if @model.present?
          flash[:success] = "You have successfully added you payment information"
          redirect_to administration_admin_payments_path
        end
      end
    end
  end
end

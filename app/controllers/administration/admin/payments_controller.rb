# frozen_string_literal: true

module Administration
  module Admin
    class PaymentsController < AdministrationController
      side_menu :administration
      namespace Administration::Admin::Payments

      def index
        run Administration::Admin::Payments::IndexOperation

        if @model.present?
          redirect_to "/administration/admin/payments"
        end
      end
    end
  end
end

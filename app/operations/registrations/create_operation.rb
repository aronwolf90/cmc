# frozen_string_literal: true

module Registrations
  class CreateOperation < ApplicationOperation
    include MvcStandardCreateOperationConcern
    success :send_wellcome_email

  private
    def send_wellcome_email(ctx, model:, **)
      OrganizationMailer
        .with(user_id: model.user.id, organization: model.organization)
        .wellcome
        .deliver_later
    end
  end
end

# frozen_string_literal: true

module Registrations
  class CreateOperation < ApplicationOperation
    success Nested(Registrations::NewOperation)
    success MvcInjectStep.new(:current_user)
    step Contract::Validate(key: :data)
    step :check_recaptcha
    success MvcCreateMutationStep
    success :send_wellcome_email

  private
    def check_recaptcha(_, recaptcha:, **)
      recaptcha
    end

    def send_wellcome_email(ctx, model:, **)
      OrganizationMailer
        .with(user_id: model.user.id, organization: model.organization)
        .wellcome
        .deliver_later
    end
  end
end

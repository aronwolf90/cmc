# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from:
    Rails.application.config.action_mailer.smtp_settings&.dig(:user_name) ||
    "info@example.com"
  layout "mailer"
end

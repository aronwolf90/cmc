# frozen_string_literal: true

class OrganizationMailer < ApplicationMailer
  def wellcome
    @organization = params[:organization]
    Apartment::Tenant.switch(@organization.name) do
      @organization_url = ApplicationHelper.organization_url(@organization)
      @user = User.find(params[:user_id])

      mail(
        to: @user.email,
        subject: "Wellcome to Ticktensio"
      )
    end
  end
end

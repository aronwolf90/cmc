# frozen_string_literal: true

class RegistrationsController < ApplicationsController
  layout: :device 

  def new
    result = run Registration::CreateOperation::Present
    render cell(Registration::Cell::Form, result["contract.default"])
  end

  def create
    run operation do |result|
      flash[:notice] = "Organization has been created"
      return redirect_to organization_sign_in_path
    end
    render cell(Registration::Cell::Form, result["contract.default"])
  end
end

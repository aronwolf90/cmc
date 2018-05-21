# frozen_string_literal: true

module ControllerSpecHelper
  def sign_in(user)
    allow_any_instance_of(Administration::AdministrationController).to receive(:authenticate_user!)
    allow_any_instance_of(Administration::AdministrationController).to receive(:current_user).and_return(user)
  end
end

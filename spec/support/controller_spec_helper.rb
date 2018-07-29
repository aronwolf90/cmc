# frozen_string_literal: true

module ControllerSpecHelper
  def sign_in(user)
    allow(controller).to receive(:authenticate_user!)
    allow(controller).to receive(:current_user).and_return(user)
  end
end

# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe GoogleCalendersController do
  describe "GET create_callback" do
    before do
      sign_in(Admin.new)
      allow(GoogleCalenders::CreateCallbackOperation)
        .to receive(:call).and_return(organization: organization)
    end

    let(:organization) { Organization.new(name: "test-name") }

    specify do
      get :create_callback, params: { code: "code", state: "test-name" }
    end
  end
end

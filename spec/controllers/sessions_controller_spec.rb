# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe SessionsController do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#create" do
    context "app is multi tentant" do
      before do
        allow(controller.helpers)
          .to receive(:organization_sign_in_url)
          .and_return("test.lvh.me")
        allow(Organization)
          .to receive(:find_by).with(name: "test").and_return(Organization.new)
        allow(Organization)
          .to receive(:find_by).with(name: "no-exist").and_return(nil)
        allow(Settings)
          .to receive(:multi_tenant).and_return(true)
      end

      specify do
        post :create, params: { organization: "test" }
        is_expected.to redirect_to "test.lvh.me"
      end

      specify do
        post :create, params: { organization: "no-exist" }
        is_expected.to redirect_to new_user_session_path
      end
    end

    context "login" do
      let!(:user) { create(:admin) }

      specify do
        post(
          :create,
          params: {
            user: {
              email: user.email,
              password: "testtest"
            }
          }
        )
        is_expected.to redirect_to administration_root_path
      end
    end
  end
end

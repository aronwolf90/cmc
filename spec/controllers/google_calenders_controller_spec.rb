# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe GoogleCalendersController do
  let(:organization) { Organization.new(id: 1, name: "test-name") }

  describe "GET create_callback" do
    before do
      sign_in(Admin.new)
      allow(GoogleCalenders::CreateCallbackOperation)
        .to receive(:call).and_return(organization: organization)
    end


    specify do
      get :create_callback, params: { code: "code", state: "test-name" }
    end
  end

  describe "GET notification" do
    subject { get :notification, params: { code: "code", state: "test-name" }  }

    before do
      sign_in(Admin.new)
      allow(Organization).to receive(:current).and_return(organization)
    end

    specify do
      expect(GoogleCalenders::ImportEventJob).to receive(:perform_later)
      subject
    end
  end
end

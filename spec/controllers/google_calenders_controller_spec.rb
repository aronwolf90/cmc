# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe GoogleCalendarsController do
  let(:organization) { Organization.new(id: 1, name: "test-name") }

  describe "GET create_callback" do
    before do
      sign_in(Admin.new)
      allow(GoogleCalendars::CreateCallbackOperation)
        .to receive(:call).and_return(organization: organization)
    end


    specify do
      get :create_callback, params: { code: "code", state: "test-name" }
    end
  end

  describe "GET notification" do
    before do
      allow(Organization).to receive(:find).and_return(organization)
    end

    specify do
      expect(GoogleCalendars::ImportEventsJob).to receive(:perform_later)
      subject
      post :notification, params: { code: "code", state: "test-name" }
    end
  end
end

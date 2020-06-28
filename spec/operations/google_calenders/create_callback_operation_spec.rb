# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_create_operation"

RSpec.describe GoogleCalenders::CreateCallbackOperation do
  let(:calender) { double(id: "test") }
  let(:organization) { Organization.new(name: "test-name") }
  let(:google_authorization_data) do
    GoogleAuthorizationData.new(
      access_token: "access_token",
      expires_at: DateTime.parse("10.10.2020 10:10:00"),
      refresh_token: "refresh_token"
    )
  end

  before do
    allow(GoogleCalenderClient)
      .to receive(:get_access_token).and_return(google_authorization_data)
    allow(GoogleCalenderClient)
      .to receive(:create_calender).and_return(calender)
    allow(GoogleCalenders::CreateCallbackMutation).to receive(:call)
  end

  specify do
    result = described_class.call(organization: organization, code: "code")

    expect(GoogleCalenderClient)
      .to have_received(:create_calender)
      .with(name: "test-name", google_authorization_data: google_authorization_data)
    expect(GoogleCalenders::CreateCallbackMutation)
      .to have_received(:call)
      .with(
        organization: organization,
        calender: calender,
        google_calender_authorization_data: google_authorization_data
      )
    expect(result[:organization]).to eq(organization)
  end
end

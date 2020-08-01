# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calenders::GoogleIntegrations::DestroyMutation do
  subject(:call) do
    described_class.call(organization: organization)
  end

  let(:organization) do
    create(
      :organization,
      google_calender_id: "test",
      google_calender_access_token: "test",
      google_calender_expires_at: Time.zone.now,
      google_calender_refresh_token: "test",
      sync_token: "test"
    )
  end
  let!(:event) { create(:event) }

  specify do
    call

    expect(organization).to have_attributes(
      google_calender_id: nil,
      google_calender_access_token: nil,
      google_calender_expires_at: nil,
      google_calender_refresh_token: "test",
      sync_token: nil
    )
    expect(event).to have_attributes(google_calender_event_id: nil)
  end
end

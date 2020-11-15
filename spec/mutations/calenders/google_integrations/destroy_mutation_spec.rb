# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calendars::GoogleIntegrations::DestroyMutation do
  subject(:call) do
    described_class.call(organization: organization)
  end

  let(:organization) do
    create(
      :organization,
      google_calendar_id: "test",
      google_calendar_access_token: "test",
      google_calendar_expires_at: Time.zone.now,
      google_calendar_refresh_token: "test",
      sync_token: "test"
    )
  end
  let!(:event) { create(:event) }

  specify do
    call

    expect(organization).to have_attributes(
      google_calendar_id: nil,
      google_calendar_access_token: nil,
      google_calendar_expires_at: nil,
      google_calendar_refresh_token: "test",
      sync_token: nil
    )
    expect(event).to have_attributes(google_calendar_event_id: nil)
  end
end

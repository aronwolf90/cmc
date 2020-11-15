# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ExportEventsOperation do
  subject(:call) do
    described_class.call(organization: organization)
  end

  let(:event) do
    Event.new(id: 1)
  end
  let(:organization) { Organization.new(google_calendar_id: "id") }

  before do
    allow(Event).to receive(:find_each).and_yield(event)
  end

  specify do
    expect(GoogleCalendars::ExportEventJob).to receive(:perform_later)
    call
  end
end

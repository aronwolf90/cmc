# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ExportEventsJob, type: :model do
  subject(:perform) { described_class.perform_now(organization) }

  let(:organization) { Organization.new }

  it "calls GoogleCalendars::ExportEventOperation" do
    expect(GoogleCalendars::ExportEventsOperation).to receive(:call)
    perform
  end
end

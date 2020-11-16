# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ExportEventJob, type: :model do
  subject(:perform) { described_class.perform_now(organization, event.id) }

  let(:organization) { Organization.new }
  let(:event) { Event.new(id: 1) }

  before do
    allow(GoogleCalendars::ExportEventOperation).to receive(:call)
    allow(Event).to receive(:unscoped).and_return(double(find: event))
  end

  it "calls Jobs::CreateNotificationsOperation" do
    perform
    expect(GoogleCalendars::ExportEventOperation).to have_received(:call)
  end
end

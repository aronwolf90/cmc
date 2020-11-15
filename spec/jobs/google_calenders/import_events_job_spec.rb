# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalendars::ImportEventsJob, type: :model do
  subject(:perform) do
    described_class.perform_now(organization)
  end

  let(:organization) { Organization.new }

  it "calls Jobs::CreateNotificationsOperation" do
    expect(GoogleCalendars::ImportEventsOperation)
      .to receive(:call)
      .with(organization: organization)
    perform
  end
end

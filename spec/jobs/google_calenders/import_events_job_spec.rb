# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ImportEventsJob, type: :model do
  subject(:perform) do
    described_class.perform_now(organization)
  end

  let(:organization) { Organization.new }

  it "calls Jobs::CreateNotificationsOperation" do
    expect(GoogleCalenders::ImportEventsOperation)
      .to receive(:call)
      .with(organization: organization)
    perform
  end
end

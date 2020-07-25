# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ImportEventJob, type: :model do
  subject(:perform) do
    described_class.perform_now(organization, "{}")
  end

  let(:organization) { Organization.new }

  it "calls Jobs::CreateNotificationsOperation" do
    expect(GoogleCalenders::ImportEventOperation).to receive(:call)
    perform
  end
end

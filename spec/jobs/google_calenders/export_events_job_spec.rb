# frozen_string_literal: true

require "rails_helper"

RSpec.describe GoogleCalenders::ExportEventsJob, type: :model do
  subject(:perform) { described_class.perform_now(organization) }

  let(:organization) { Organization.new }

  it "calls GoogleCalenders::ExportEventOperation" do
    expect(GoogleCalenders::ExportEventsOperation).to receive(:call)
    perform
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Events::ExportOperation do
  subject(:call) do
    described_class.call(
      organization: organization,
      event: event,
      exporters: exporters
    )
  end

  let(:exporters) { [double(perform_later: nil)] }
  let(:event) { Event.new(id: 1) }
  let(:organization) { Organization.new }

  before do
    allow(exporters.first).to receive(:perform_later)
  end

  specify do
    call
    expect(exporters.first).to have_received(:perform_later).
      with(organization, 1)
  end
end

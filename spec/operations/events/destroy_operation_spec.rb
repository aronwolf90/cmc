# frozen_string_literal: true

require "rails_helper"

RSpec.describe Events::DestroyOperation do
  subject(:call) do
    described_class.(
      organization: organization,
      event: event
    )
  end

  let(:event) { Event.new }
  let(:organization) { Organization.new }

  specify do
    expect(event).to receive(:destroy!)
    expect(Events::ExportJob).to receive(:perform_later)
    call
  end
end

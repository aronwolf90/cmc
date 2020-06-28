# frozen_string_literal: true

require "rails_helper"

RSpec.describe Events::UpdateOperation do
  subject(:call) do
    described_class.(
      organization: organization,
      model: Event.new,
      attributes: {}
    )
  end

  let(:event) { Event.new }
  let(:organization) { Organization.new }

  before do
    allow(StandardUpdateMutation).to receive(:call)
    allow(Events::ExportJob).to receive(:perform_later)
  end

  specify do
    call
    expect(StandardUpdateMutation).to have_received(:call)
    expect(Events::ExportJob).to have_received(:perform_later)
  end
end

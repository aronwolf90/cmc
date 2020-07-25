# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standard_operations"

RSpec.describe Api::V1::Events::DestroyOperation do
  subject(:call) do
    described_class.(
      organization: organization,
      params: { id: "1" }
    )
  end

  let(:organization) { Organization.new }
  let(:event) { Event.new }

  specify do
    expect(Event).to receive(:find).with("1").and_return(event)
    expect(::Events::DestroyOperation)
      .to receive(:call).with(organization: organization, event: event)
    call
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Calenders::GoogleIntegrations::DestroyOperation do
  let(:organization) { Organization.new }

  specify do
    expect(Calenders::GoogleIntegrations::DestroyMutation)
      .to receive(:call)
      .with(organization: organization)

    described_class.call(organization: organization)
  end
end

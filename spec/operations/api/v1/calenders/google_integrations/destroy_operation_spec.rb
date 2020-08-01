# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Calenders::GoogleIntegrations::DestroyOperation do
  subject(:call) do
    described_class.call(
      organization: organization,
      params: {},
      current_user: Admin.new
    )
  end

  let(:organization) { Organization.new }

  specify do
    expect(Calenders::GoogleIntegrations::DestroyMutation)
      .to receive(:call)
      .with(organization: organization)

    call
  end
end

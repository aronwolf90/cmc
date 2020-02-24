# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::CreateOperation do
  subject do
    described_class.call(params: {})
  end

  it "calls Notifications::CreateMutation" do
    expect(Notifications::CreateMutation).to receive(:call)

    subject
  end
end

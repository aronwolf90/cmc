# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issues::CloseOperation do
  it "calls Notifications::CreateMutation" do
    model = Issue.new
    expect(Issues::CloseMutation).to receive(:call).with(model: model)

    described_class.call(model: model)
  end
end

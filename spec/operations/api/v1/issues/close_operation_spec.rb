# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Issues::CloseOperation do
  it "call Issues::CloseOperation" do
    model = Issue.new
    allow(Issue).to receive(:find).and_return(model)
    expect(::Issues::CloseOperation)
      .to receive(:call).with(model: model)

    described_class.call(params: { issue_id: 1 })
  end
end

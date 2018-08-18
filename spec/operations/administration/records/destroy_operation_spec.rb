# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::DestroyOperation do
  subject { described_class.(params: {}, current_user: current_user) }

  let(:record) { build_stubbed(:record) }
  let(:current_user) { build_stubbed(:admin)  }

  before do
    allow(Record).to receive(:find).and_return(record)
  end

  it "call destroy" do
    expect(record).to receive(:destroy!)
    subject
  end
end

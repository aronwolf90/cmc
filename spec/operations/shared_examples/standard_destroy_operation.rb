# frozen_string_literal: true

RSpec.shared_examples "standard destroy operation" do
  subject do
    described_class.(params: { id: model.id }, current_user: user)
  end

  let(:user) { build_stubbed(:admin) }

  before do
    allow(model.class).to receive(:find).and_return(model)
  end

  it "call destroy" do
    expect(model).to receive(:destroy!)
    subject
  end
end

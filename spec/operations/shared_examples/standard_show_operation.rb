# frozen_string_literal: true

RSpec.shared_examples "standard show operation" do |params = { id: 1 }|
  subject do
    described_class.(params: params.merge(id: model.id), current_user: current_user)
  end
  let(:current_user) { Admin.new }

  before do
    allow(model.class).to receive(:find).and_return(model)
  end

  it "model is set" do
    expect(subject[:model]).to eq(model)
  end
end

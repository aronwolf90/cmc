# frozen_string_literal: true

RSpec.shared_examples "standard show action" do
  describe "GET show" do
    subject { get :show, params: { id: model.id } }

    let(:user) { build_stubbed(:user) }

    before do
      allow(model.class).to receive(:find).and_return(model)
      sign_in user
    end

    it "pass collection to render" do
      expect(controller)
        .to receive(:render).with(json: model, include: nil) do
        controller.head :ok
      end
      subject
    end
  end
end
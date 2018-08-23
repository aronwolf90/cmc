# frozen_string_literal: true

RSpec.shared_examples "standard api destroy action" do
  describe "DELETE destroy" do
    subject { delete :destroy, params: { id: model.id } }

    let(:user) { build_stubbed(:user) }

    before do
      allow(model.class).to receive(:find).and_return(model)
      sign_in user
    end

    it "pass collection to render" do
      expect(model).to receive(:destroy!)
      subject
    end
  end
end

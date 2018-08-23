# frozen_string_literal: true

RSpec.shared_examples "standard destroy action" do |namespace, redirect|
  describe "DELETE destroy" do
    let(:user) { build_stubbed(:user) }

    before do
      allow(operation).to receive(:call).and_return(operation_result)
      sign_in(user)
      subject
    end

    subject { delete :destroy, params: { id: model } }

    let(:operation) { namespace::DestroyOperation }
    let(:operation_result) do
      OpenStruct.new("model" => model, "contract.default": form.new(model))
    end

    it "redirect" do
      expect(response).to redirect_to(redirect)
    end
  end
end

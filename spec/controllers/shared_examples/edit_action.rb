# frozen_string_literal: true

RSpec.shared_examples "standard edit action" do |namespace, params: nil|
  describe "GET edit" do
    let(:user) { Admin.new }

    before do
      allow(operation).to receive(:call).and_return(operation_result)
      sign_in(build_stubbed(:user))
      subject
    end

    subject { get :edit, params: params || { id: model.id } }

    let(:operation_result) do
      OpenStruct.new("model" => model, "contract.default": form.new(model))
    end
    let(:operation) { namespace::UpdateOperation::Present }

    it "call operation" do
      expect(operation).to have_received(:call)
    end
  end
end

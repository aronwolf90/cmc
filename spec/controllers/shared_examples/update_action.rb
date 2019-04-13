# frozen_string_literal: true

RSpec.shared_examples "standard update action" do
  |namespace, redirect, params: nil|

  describe "PUT update" do
    let(:user) { Admin.new }

    before do
      sign_in(user)
      allow(operation).to receive(:call)
        .and_return(operation_result)
      subject
    end

    subject { put :update, params: params || { id: model.id } }

    let(:operation) { namespace::UpdateOperation }

    context "valid" do
      let(:operation_result) do
        OpenStruct.new(
          "model" => model,
          success?: true,
          "contract.default": form.new(model)
        )
      end

      it "redirect" do
        expect(response).to redirect_to(redirect)
      end
    end

    context "invalid" do
      let(:operation_result) do
        OpenStruct.new(
          "model" => model,
          success?: false,
          "contract.default": form.new(model)
        )
      end
    end
  end
end

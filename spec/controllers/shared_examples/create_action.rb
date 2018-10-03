# frozen_string_literal: true

RSpec.shared_examples "standard create action" do
  |namespace, redirect, params: {}, cell: namespace::Cell::Form|

  describe "POST create" do
    let(:user) { Admin.new }

    before do
      cell_instance = Cell::ViewModel.new

      allow(operation).to receive(:call).and_return(operation_result)
      allow(cell).to receive(:call).and_return(cell_instance)
      allow(cell_instance).to receive(:call).and_return("")
      sign_in(user)
      subject
    end

    subject { post :create, params: params }

    let(:operation) { namespace::CreateOperation }

    context "valid" do
      let(:operation_result) do
        OpenStruct.new("model" => model, success?: true, "contract.default": form.new(model))
      end

      it "call create operation" do
        expect(operation).to have_received(:call)
      end

      it "redirect" do
        expect(response).to redirect_to(redirect)
      end
    end

    context "invalid" do
      let(:operation_result) { OpenStruct.new("model" => model, success?: false) }

      it "call operation" do
        expect(operation).to have_received(:call)
      end

      it "call cell" do
        expect(cell).to have_received(:call)
      end
    end
  end
end

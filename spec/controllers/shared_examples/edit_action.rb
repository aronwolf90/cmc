# frozen_string_literal: true

RSpec.shared_examples "standard edit action" do
  |namespace, params: nil, cell: namespace::Cell::Form|

  describe "GET edit" do
    let(:user) { build_stubbed(:user) }

    before do
      cell_instance = Cell::ViewModel.new

      allow(operation).to receive(:call).and_return(operation_result)
      allow(cell).to receive(:call).and_return(cell_instance)
      allow(cell_instance).to receive(:call).and_return("")
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

    it "call cell" do
      expect(operation).to have_received(:call)
    end
  end
end

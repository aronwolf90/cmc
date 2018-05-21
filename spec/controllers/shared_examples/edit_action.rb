# frozen_string_literal: true

RSpec.shared_examples "standart edit action" do |namespace|
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

    subject { get :edit, params: { id: model.id } }

    let(:operation_result) { OpenStruct.new("model" => model) }
    let(:operation) { namespace::UpdateOperation::Present }
    let(:cell) { namespace::Cell::Form }

    it "call operation" do
      expect(operation).to have_received(:call)
    end

    it "call cell" do
      expect(operation).to have_received(:call)
    end
  end
end

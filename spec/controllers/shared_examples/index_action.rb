# frozen_string_literal: true

RSpec.shared_examples "standard index action" do |namespace|
  describe "GET index" do
    let(:form) { Administration::RecordForm }
    let(:user) { Admin.new }

    before do
      cell_instance = Cell::ViewModel.new

      allow(operation).to receive(:call).and_return(operation_result)
      allow(cell).to receive(:call).and_return(cell_instance)
      allow(cell_instance).to receive(:call).and_return("")
      sign_in(build_stubbed(:user))
      subject
    end

    subject { get :index, params: params }

    let(:model) { [] }
    let(:operation_result) { OpenStruct.new("model" => model) }
    let(:operation) { namespace::IndexOperation }
    let(:cell) { namespace::Cell::Index }

    it "call operation" do
      expect(operation).to have_received(:call)
    end

    it "call cell" do
      expect(operation).to have_received(:call)
    end
  end
end

RSpec.shared_examples "standard csv index action" do |namespace|
  describe "GET index" do
    subject { get :index, params: params.merge(format: :csv) }

    let(:user) { Admin.new }
    let(:model) { [] }
    let(:result) { OpenStruct.new("model" => model) }
    let(:operation) { namespace::IndexCsvOperation }

    before do
      sign_in(build_stubbed(:user))
      allow(result).to receive(:[]).with(:model).and_return(model)
      allow(result).to receive(:[]).with("model").and_return(nil)
      allow(result).to receive(:[]).with(:parent).and_return(nil)
      allow(result).to receive(:[]).with("contract.default").and_return(nil)
      allow(controller).to receive(:send_data)
      allow(operation).to receive(:call).and_return(result)
      allow("#{namespace}CsvExporter".constantize).to receive(:call)
      subject
    end

    it "call operation" do
      expect(operation).to have_received(:call)
    end

    it "call send" do
      expect(controller).to have_received(:send_data)
    end

    it "call exporter" do
      expect("#{namespace}CsvExporter".constantize).to have_received(:call)
    end
  end
end

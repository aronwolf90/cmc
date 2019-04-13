# frozen_string_literal: true

RSpec.shared_examples "standard show action" do
  |namespace, params: {}|

  describe "GET show" do
    let(:user) { Admin.new }

    before do
      allow(operation).to receive(:call).and_return(operation_result)
      sign_in(build_stubbed(:user))
      subject
    end

    subject { get :show, params: params.merge(id: model.id) }

    let(:operation_result) { OpenStruct.new("model" => model) }
    let(:operation) { namespace::ShowOperation }

    it "call operation" do
      expect(operation).to have_received(:call)
    end
  end
end

RSpec.shared_examples "basic show action" do |params: {}|
  describe "GET show" do
    let(:user) { Admin.new }

    before do
      sign_in(build_stubbed(:user))
      subject
    end

    subject { get :show, params: params }

    it "call cell" do
    end
  end
end

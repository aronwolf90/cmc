# frozen_string_literal: true

RSpec.shared_examples "standard new action" do |namespace, params: {}|
  describe "GET new" do
    let(:user) { ADmin.new }

    before do
      allow(operation).to receive(:call).and_return(operation_result)
      sign_in(build_stubbed(:user))
      subject
    end

    subject { get :new, params: params }

    let(:operation_result) { OpenStruct.new("model" => model) }
    let(:operation) { namespace::NewOperation }

    it "call operation" do
      expect(operation).to have_received(:call)
    end
  end
end

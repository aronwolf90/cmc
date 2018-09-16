# frozen_string_literal: true

RSpec.shared_examples "standard api create action" do |operation|
  describe "PUT udate" do
    subject { post :create }

    let(:user) { build_stubbed(:user) }
    let(:params) {
      {
        "controller" => "api/v1/#{model.class.name.underscore.pluralize}",
        "action" => "create"
      }
    }
    let(:result) { double(success?: true)  }

    before do
      allow(result).to receive(:[]).with(:model).and_return(nil)
      allow(result).to receive(:[]).with("model").and_return(nil)
      allow(result).to receive(:[]).with(:parent).and_return(nil)
      allow(result).to receive(:[]).with("contract.default").and_return(nil)
      sign_in user
    end

    it "pass collection to render" do
      expect(operation).to receive(:call)
        .with(current_user: user, params: params)
        .and_return(result)
      subject
    end
  end
end

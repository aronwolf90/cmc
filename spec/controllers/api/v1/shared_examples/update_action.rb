# frozen_string_literal: true

RSpec.shared_examples "standard api update action" do |operation|
  describe "PUT udate" do
    subject { put :update, params: { id: model.id } }

    let(:user) { build_stubbed(:user) }
    let(:params) {
      {
        "id" => model.id.to_s,
        "controller" => "api/v1/#{model.class.name.underscore.pluralize}",
        "action" => "update"
      }
    }
    let(:result) { double(success?: true)  }

    before do
      allow(model.class).to receive(:find).and_return(model)
      allow(result).to receive(:[]).with(:model).and_return(model)
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


RSpec.shared_examples "simple api update action" do |operation, params:|
  describe "PUT udate" do
    subject { put :update, params: params }

    let(:user) { build_stubbed(:user) }
    let(:result) { double(success?: true)  }

    before do
      allow(result).to receive(:[])
        .with(:parent).and_return(nil)
      allow(result).to receive(:[])
        .with(:model).and_return(nil)
      allow(result).to receive(:[])
        .with("model").and_return(nil)
      allow(result).to receive(:[])
        .with("contract.default").and_return(nil)
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

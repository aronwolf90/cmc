# frozen_string_literal: true

RSpec.shared_examples "standard api update action" do |operation|
  describe "PUT udate" do
    subject { put :update, params: { id: model.id } }

    let(:user) { Admin.new }
    let(:params) {
      {
        "id" => model.id.to_s,
        "controller" => "api/v1/#{model.class.name.underscore.pluralize}",
        "action" => "update"
      }
    }

    before do
      allow(model.class).to receive(:find).and_return(model)
      allow(result).to receive(:[]).with(:model).and_return(model)
      allow(result).to receive(:[]).with("model").and_return(nil)
      allow(result).to receive(:[]).with(:parent).and_return(nil)
      allow(result).to receive(:[]).with("contract.default").and_return(nil)
      errors = ActiveModel::Errors.new(nil)
      errors.add(:base, ["ERROR"])
      allow(result).to receive(:[]).with(:errors).and_return(errors)
      sign_in user
    end

    context "valid request" do
      let(:result) { double(success?: true)  }

      it "pass collection to render" do
        expect(operation).to receive(:call)
          .with(current_user: user, params: params)
          .and_return(result)
        subject
      end
    end

    context "invalid request" do
      let(:result) { double(success?: false)  }

      specify do
        expect(operation).to receive(:call)
          .with(current_user: user, params: params)
          .and_return(result)
        expect(controller).to receive(:render_errors).and_call_original
        subject
      end
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

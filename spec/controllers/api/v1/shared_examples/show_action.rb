# frozen_string_literal: true

RSpec.shared_examples "standard api show action" do
  describe "GET show" do
    subject { get :show, params: { id: model.id.to_s } }

    let(:user) { Admin.new }

    before do
      allow(model.class).to receive(:find).and_return(model)
      sign_in user
    end

    it "pass collection to render" do
      expect(controller)
        .to receive(:render).with(json: model, include: nil) do
        controller.head :ok
      end
      subject
    end
  end
end


RSpec.shared_examples "simple api show action" do |params: {}|

  describe "GET show" do
    subject { get :show, params: params }

    before do
      sign_in respond_to?(:user) ? user : build_stubbed(:user)
    end

    it "pass collection to render" do
      expect(controller)
        .to receive(:render).with(json: model, include: nil) do
        controller.head :ok
      end
      subject
    end
  end
end

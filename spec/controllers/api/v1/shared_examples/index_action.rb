# frozen_string_literal: true

RSpec.shared_examples "standard index action" do |namespace|
  describe "GET index" do
    subject { get :index }

    let(:user) { build_stubbed(:user) }

    before do
      allow(JsonApiQuery).to receive(:call).and_return([model])
      sign_in user
    end

    it "pass collection to render" do
      expect(controller)
        .to receive(:render).with(json: [model], include: nil) do
        controller.head :ok
      end
      subject
    end
  end
end

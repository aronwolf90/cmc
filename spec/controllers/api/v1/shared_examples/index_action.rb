# frozen_string_literal: true

RSpec.shared_examples "standard api index action" do |_namespace|
  describe "GET index" do
    subject { get :index }

    let(:user) { Admin.new }

    before do
      allow(JsonApiQuery).to receive(:call)
        .and_return(Kaminari.paginate_array([model]))
      sign_in user
    end

    it "pass collection to render" do
      expect(controller)
        .to receive(:render).with(hash_including(json: [model])) do
        controller.head :ok
      end
      subject
    end
  end
end

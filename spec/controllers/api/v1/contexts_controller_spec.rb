# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::ContextsController, type: :controller do
  let(:user) { User.new(id: 1) }

  before { sign_in user }

  describe "#show" do
    subject { get :show }

    specify do
      allow(User).to receive(:count).and_return 1
      expect(controller).to receive(:render).and_call_original do |hash|
        expect(hash[:json]).to be_a Context
      end
      subject
    end
  end

  describe "#update" do
    subject { put :update }

    specify do
      controller.update_operation = double

      expect(controller.update_operation)
        .to receive(:call)

      subject
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::DestroyMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model
    )
  end

  let!(:current_user) { create(:admin) }
  let!(:model) { create(:admin) }

  context "when the user has no records" do
    it "destroy user when the user has no records" do
      expect { subject }.to change(User, :count).by(-1)
    end
  end

  context "when the user has records" do
    before { create(:record, user: model) }

    it "deactivate user" do
      expect { subject }.to change(model, :active).from(true).to(false)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::CreateMutation do
  subject do
    described_class.call(
      user: current_user,
      model: model
    )
  end

  let!(:current_user) { create(:admin) }
  let(:model) { build(:admin) }

  it "create user" do
    expect { subject }.to change(User, :count).by(1)
  end
end

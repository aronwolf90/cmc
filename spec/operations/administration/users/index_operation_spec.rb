# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::IndexOperation do
  subject { described_class.(current_user: user) }

  let(:user) { User.new }

  before { expect(UserPolicy::Scope).to receive(:call).and_return([]) }

  it "model is set" do
    expect(subject["model"]).to eq([])
  end
end

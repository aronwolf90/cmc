# frozen_string_literal: true

require "rails_helper"

RSpec.describe Context, type: :model do
  subject { Context.new(current_user: current_user) }

  let(:current_user) { build_stubbed(:user) }

  describe "#current_user_id" do
    specify do
      expect(subject.current_user_id).to eq(current_user.id)
    end
  end
end

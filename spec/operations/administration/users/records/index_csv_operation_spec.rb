# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Users::Records::IndexCsvOperation do
  subject do
    described_class.(
      params: { user_id: user.id },
      current_user: user
    )
  end

  let(:user) { build_stubbed(:user, records: [record]) }
  let(:record) { build_stubbed(:record) }

  before do
    allow(User).to receive(:find).and_return(user)
  end

  it "model option is equal to record_days" do
    expect(subject[:model]).to eq([record])
  end
end

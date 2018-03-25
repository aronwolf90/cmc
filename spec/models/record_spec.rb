# frozen_string_literal: true

require "rails_helper"

RSpec.describe Record, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:issue) }

  it "raise an error on create a second active record" do
    user = create(:user)
    create(:record, user: user, end_time: nil)
    expect { create(:record, user: user, end_time: nil) }.to raise_error
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Jobs::CreateNotificationsMutation do
  subject do
    described_class.call(
      issues_due_at: issues_due_at,
      issues_deadline_at: issues_deadline_at
    )
  end

  let(:user) { create(:admin) }
  let(:issues_due_at) { [create(:issue, user: user)] }
  let(:issues_deadline_at) { [create(:issue, user: user)] }

  specify do
    expect { subject }.to change(Notification, :count).by(2)
    expect(subject.size).to eq(2)
  end
end

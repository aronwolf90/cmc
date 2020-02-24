# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::CreateIssueDeadlineAtMutation do
  subject do
    described_class.call(
      issue: issue
    )
  end

  let(:issue) { create(:issue, due_at: "10-10-2020 00:00:00", user: create(:admin)) }

  specify do
    expect { subject }.to change(Notification, :count).by(1)

    expect(subject).to have_attributes(
      subject: "Deadline at of an ticket will be reached soon",
      body: "The deadline at for the issue \"#{issue}\" is at 10-10-2020 00:00",
      issue: issue
    )
  end
end

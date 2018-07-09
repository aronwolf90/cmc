# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserIssueRecordsQuery do
  subject { described_class.call(user: user, issue: issue) }

  let(:user) { create(:user) }
  let(:issue) { create(:issue)  }
  let(:user_record) { create(:record, user: user, issue: issue) }
  let(:other_record) { create(:record, issue: issue) }

  it "returns the users record" do
    is_expected.to include user_record
  end

  it "not return the other records" do
    is_expected.not_to include other_record
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Administration::Records::Preloader do
  subject { described_class.(user, user.record_days) }

  let(:user) { create(:admin) }
  let(:issue) { create(:issue) }

  before do
    create(:organization, name: "public")
    create(:record, user: user, issue: issue)
  end

  it do
    subject
    expect do
      subject.last.records.first.issue
    end.not_to make_database_queries
  end
end

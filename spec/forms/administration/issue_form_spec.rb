# frozen_string_literal: true

require "rails_helper"

describe Administration::IssueForm do
  subject { described_class.new(issue) }

  let(:issue) { build_stubbed(:issue, board_list: board_list) }
  let(:board_list) { build_stubbed(:board_list) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(board_list_id: nil)).to be false }
  it { expect(subject.validate(board_list_id: board_list.id)).to be true }
  it { expect(subject.validate(title: nil)).to be false }
  it { expect(subject.validate(description: nil)).to be false }
end

# frozen_string_literal: true

require "rails_helper"

describe Administration::BoardListForm do
  subject { described_class.new(board_list) }

  let(:board_list) { build_stubbed(:board_list) }
  let(:project) { build_stubbed(:project) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(project_id: nil)).to be true }
  it { expect(subject.validate(project_id: project.id)).to be true }
  it { expect(subject.validate(name: nil)).to be false }
end

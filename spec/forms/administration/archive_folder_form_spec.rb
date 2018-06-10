# frozen_string_literal: true

require "rails_helper"

describe Administration::ArchiveFolderForm do
  subject { described_class.new(folder) }

  let(:folder) { build_stubbed(:folder, folder: parent_folder) }
  let(:parent_folder) { build_stubbed(:folder) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(name: nil)).to be false }
  it { expect(subject.validate(folder_id: parent_folder.id)).to be true }
end

# frozen_string_literal: true

require "rails_helper"

describe Administration::WikiCategoryForm do
  subject { described_class.new(wiki_category) }

  let(:wiki_category) { build_stubbed(:wiki_category) }
  let(:parent_category) { build_stubbed(:wiki_category) }

  it { expect(subject.validate({})).to be true }
  it { expect(subject.validate(title: nil)).to be false }
  it { expect(subject.validate(wiki_category_id: parent_category.id)).to be true }
end

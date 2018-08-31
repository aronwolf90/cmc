# frozen_string_literal: true

require "rails_helper"

RSpec.describe Issue, type: :model do
  subject { build_stubbed(:issue)  }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :board_list }
  it { is_expected.to have_many :comments }
  it { is_expected.to have_many :records }
  it { is_expected.to have_one :project }

  describe "#to_s" do
    it { expect(subject.to_s).to eq(subject.title) }
  end
end

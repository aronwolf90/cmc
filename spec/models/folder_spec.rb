# frozen_string_literal: true

require "rails_helper"

RSpec.describe Folder, type: :model do
  it { is_expected.to belong_to :folder }
  it { is_expected.to have_many :folders }
  it { is_expected.to have_many :documents }

  describe "#root?" do
    context "has no parent folder" do
      subject { build_stubbed(:folder, folder: nil)  }

      it { is_expected.to be_root }
    end

    context "has a parent folder" do
      subject { build_stubbed(:folder, folder: build_stubbed(:folder)) }

      it { is_expected.not_to be_root }
    end
  end
end

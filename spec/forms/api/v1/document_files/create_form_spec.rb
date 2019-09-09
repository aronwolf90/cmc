# frozen_string_literal: true

require "rails_helper"

describe Api::V1::DocumentFiles::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        file: Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec", "fixtures", "avatar.png"))),
        not_finished: true
      }
    }
  end

  context "with valid params" do
    it { is_expected.to be_success }
  end

  context "when not_finished is present" do
    before { params[:data].delete(:not_finished) }

    it { is_expected.to be_success }
  end
end

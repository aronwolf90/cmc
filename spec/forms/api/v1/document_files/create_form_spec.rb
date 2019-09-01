# frozen_string_literal: true

require "rails_helper"

describe Api::V1::DocumentFiles::CreateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        file: Rack::Test::UploadedFile.new(File.open(Rails.root.join("spec", "fixtures", "avatar.png")))
      }
    }
  end

  context "with valid params" do
    it { is_expected.to be_success }
  end
end

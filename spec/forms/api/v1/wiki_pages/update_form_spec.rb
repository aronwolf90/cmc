
# frozen_string_literal: true

require "rails_helper"

describe Api::V1::WikiPages::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        id: "1",
        type: "wiki-pages",
        attributes: {
          "title": "new wiki pages title",
          "content": "new content"
        }
      }
    }
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "when title is empty" do
    before { params[:data][:attributes][:title] = "" }

    it { is_expected.not_to be_success }
  end

  context "when content is empty" do
    before { params[:data][:attributes][:content] = "" }

    it { is_expected.not_to be_success }
  end
end

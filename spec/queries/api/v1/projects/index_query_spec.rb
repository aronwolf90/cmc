# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Projects::IndexQuery do
  context "when created at is not equal" do
    let(:created_at) { Time.zone.parse("01.01.2020 10:10:10") }
    let(:project1) { create(:project, id: 2, created_at: created_at) }
    let(:project2) { create(:project, id: 1, created_at: created_at) }

    it "return ordered id: asc" do
      expect(described_class.call).to eq([project2, project1])
    end
  end

  context "when created at is not equal" do
    let(:project1) { create(:project, created_at: Time.zone.parse("01.01.2020 10:10:11")) }
    let(:project2) { create(:project, created_at: Time.zone.parse("01.01.2020 10:10:10")) }

    it "return ordered created_at: asc" do
      expect(described_class.call).to eq([project2, project1])
    end
  end

  context "when the query is passed" do
    let!(:project1) { create(:project, name: "first") }
    let!(:project2) { create(:project, name: "second") }

    it "return queried entry" do
      expect(described_class.call(query: "first")).to eq([project1])
    end
  end
end

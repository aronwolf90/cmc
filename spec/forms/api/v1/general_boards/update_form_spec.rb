# frozen_string_literal: true

require "rails_helper"

describe Api::V1::GeneralBoards::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        relationships: {
          "board-lists": {
            data: [{
              id: "1",
              type: "board-lists",
              relationships: { issues: { data: [{ id: "1", type: "issues" }] } }
            }]
          }
        }
      }
    }
  end

  before do
    allow(Issue).to receive(:exists?).with("1").and_return(true)
    allow(BoardList).to receive(:exists?).with("1").and_return(true)
  end

  context "with valid params" do
    it "form is valid" do
      expect(subject).to be_success
    end
  end

  context "without board-list id" do
    before { params[:data][:relationships][:"board-lists"][:data][0][:id] = nil }

    it "it has an error: id must be filled" do
      expect(subject.errors).to eq(
        data: { relationships: {
          "board-lists": { data: { 0 => { id: ["must be filled"] } } }
        } })
    end
  end

  context "without issue id" do
    before do
      params[:data][:relationships][:"board-lists"][:data][0] \
            [:relationships][:issues][:data][0][:id] = nil
    end

    it "it has an error: id must be filled" do
      expect(subject.errors.to_json).to include({id: ["must be filled"]}.to_json)
    end
  end
end

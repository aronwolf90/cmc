# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::BoardLists::UpdateOperation do
  subject do
    described_class.(
      params: params,
      current_user: user
    )
  end

  let(:user) { Admin.new }
  let(:board_list) { BoardList.new }
  let(:params) do
    {
      data: {
        id: "1",
        type: "board-lists",
        attributes: { name: "name" },
        relationships: {
          issues: { data: [{ id: "1", type: "issues" }] }
        }
      }
    }
  end
  let(:form_result) { OpenStruct.new(errors: []) }
  let(:deserialized_params) do
    {
      name: "name",
      issue_ids: [1],
      issues_attributes: [{ id: 1, ordinal_number: 0 }]
    }
  end

  before do
    allow(BoardList).to receive(:find).and_return(board_list)
    allow(Api::V1::BoardLists::UpdateForm).to receive(:call).with(params).and_return(form_result)
    allow(Api::V1::BoardListDeserializer).to receive(:call).with(params[:data]).and_return(deserialized_params)
    allow(board_list).to receive(:update!)
  end

  it "call update!" do
    expect(board_list).to receive(:update!).with(deserialized_params)
    subject
  end

  it { is_expected.to be_success }

  context "invalid params" do
    before do
      params[:data][:relationships][:"issues"][:data][0][:id] = nil
      form_result.errors = {
        data: { relationships: { "issues": { data: { 0 => { id: ["must be filled"] } } } } }
      }
    end

    it "not call update!" do
      expect(board_list).not_to receive(:update!).with(deserialized_params)
    end

    it { is_expected.not_to be_success }
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Issues::CreateOperation do
  subject { described_class.(params: params) }

  let(:board_list) { build_stubbed(:board_list)  }

  before do
    allow(Administration::IssueForm)
      .to receive(:new).and_return(form)
    allow(form).to receive(:save).and_return(true)
    allow(BoardList).to receive(:find).and_return(board_list)
  end

  context "valid params" do
    let(:params) do
      {
        data: {
          title: "title",
          description: "description"
        },
        board_list_id: board_list.id
      }
    end
    let(:form) { double()  }

    before do
      allow(form).to receive(:call).and_return(double(success?: true))
    end

    it { is_expected.to be_success }

    it do
      subject
      expect(form).to have_received(:save)
    end
  end

  context "invalid params" do
    let(:params) do
      {
        data: {
          title: nil,
          description: "description"
        },
        board_list_id: board_list.id
      }
    end
    let(:form) { double()  }

    before do
      allow(form).to receive(:call).and_return(double(success?: false))
    end

    it { is_expected.to be_failure }

    it do
      subject
      expect(form).not_to have_received(:save)
    end
  end
end

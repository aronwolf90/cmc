# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::UpdateOperation do
  subject do
    described_class.(params: params, current_user: current_user)
  end

  let(:record) { build_stubbed(:record) }

  before do
    allow(Administration::RecordForm)
      .to receive(:new).and_return(form)
    allow(Records::UpdateMutation).to receive(:call)
    allow(Record).to receive(:find).and_return(record)
  end

  let(:current_user) { build_stubbed(:admin)  }

  context "valid params" do
    let(:params) do
      {
        data: {
          start_time: 1.hour.ago,
          end_time: 1.hour.from_now,
          user_id: 1,
          issue_id: 1
        }
      }
    end
    let(:form) { double()  }

    before do
      result = double(success?: true)
      allow(form).to receive(:call).and_return(result)
      allow(result).to receive(:save).and_yield(params[:data])
    end

    it { is_expected.to be_success }

    it "create mutation is called" do
      subject
      expect(::Records::UpdateMutation).to have_received(:call)
    end
  end

  context "invalid params" do
    let(:params) do
      {
        data: {
          start_time: nil
        }
      }
    end
    let(:form) { double() }

    before do
      allow(form).to receive(:call).and_return(double(success?: false))
    end

    it { is_expected.to be_failure }

    it "create mutation is not called" do
      subject
      expect(::Records::UpdateMutation).not_to have_received(:call)
    end
  end
end

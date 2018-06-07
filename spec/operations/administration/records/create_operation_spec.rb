# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administration::Records::CreateOperation do
  subject do
    described_class.(params: params, current_user: current_user)
  end

  before do
    allow(Administration::RecordForm)
      .to receive(:new).and_return(form)
    allow(Records::CreateMutation).to receive(:call)
  end

  let(:current_user) { build_stubbed(:user)  }

  context "valid params" do
    let(:params) do
      {
        data: {
          start_time: 1.hour.ago,
          end_time: 1.hour.from_now,
          user_id: 1,
          issu_id: 1
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
      expect(::Records::CreateMutation).to have_received(:call)
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
      expect(::Records::CreateMutation).not_to have_received(:call)
    end
  end
end

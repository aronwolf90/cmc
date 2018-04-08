# frozen_string_literal: true

require "rails_helper"

RSpec.describe Records::EnsureUniqueActiveStep do
  subject { described_class.new }

  let(:current_user) { build_stubbed(:user, current_record: current_record) }

  context "when the model is active" do
    let(:model) { build(:record, end_time: nil) }

    context "when a current_record exist" do
      let(:current_record) { build_stubbed(:record, end_time: nil) }

      it "call update on current_record" do
        expect(current_record).to receive(:update!)
        subject.call(nil, model: model, current_user: current_user)
      end
    end

    context "when the current record is the model" do
      let(:current_record) { model }

      it "call update on current_record" do
        expect(current_record).not_to receive(:update!)
        subject.call(nil, model: model, current_user: current_user)
      end
    end

    context "when no current record exist" do
      let(:current_record) { nil }

      it "call update on current_record" do
        expect do
          subject.call(nil, model: model, current_user: current_user)
        end.not_to raise_error
      end
    end
  end

  context "when the model is inactive" do
    let(:model) { build(:record, end_time: Time.zone.now) }
    let(:current_record) { build_stubbed(:record, end_time: nil) }

    it "not call update on current_record" do
      expect(current_record).not_to receive(:update!)
      subject.call(nil, model: model, current_user: current_user)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Api::V1::AttendanceEvents::UpdateForm do
  subject { described_class.call(params) }

  let(:params) do
    {
      data: {
        attributes: {
          "from-day": "1.1.2019",
          "to-day": "1.1.2019",
          "from-time": "09:00",
          "to-time": "18:00",
          "description": "test description"
        },
        relationships: {
          user: {
            data: {
              id: "1",
              type: "admins"
            }
          }
        }
      }
    }
  end

  before do
    allow(Admin).to receive(:exists?).and_return true
  end

  it "form is valid" do
    expect(subject).to be_success
  end

  context "without values inside attributes and without user" do
    before do
      params[:data][:attributes]
      params[:data].delete(:relationships)
    end

    it "has an error" do
      expect(subject).to be_success
    end
  end
end

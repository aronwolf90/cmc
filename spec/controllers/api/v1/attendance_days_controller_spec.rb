# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::AttendanceDaysController, type: :controller do
  let(:attendance_days) { (0..14).map { instance_double(AttendanceDay) } }

  describe "GET index" do
    before do
      sign_in(Admin.new)
      allow(AttendanceDay).to receive(:from_to).and_return(attendance_days)
    end

    context "when page[number] is present" do
      it "render the json with indicated page" do
        expect(controller).to receive(:render).with(
          json: attendance_days,
          links: {
            first: nil,
            last: nil,
            prev: "/api/v1/attendance_days?from_date=2019-01-01",
            next: "/api/v1/attendance_days?from_date=2019-01-29",
            meta: {
              prev: "2019-01-01".to_date,
              current: "2019-01-15".to_date,
              next: "2019-01-29".to_date
            }
          }
        ).and_call_original

        get :index, params: { page: { number: "2019-01-15" } }
      end
    end
  end
end

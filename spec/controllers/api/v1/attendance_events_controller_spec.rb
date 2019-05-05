# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::AttendanceEventsController do
  let(:model) { AttendanceEvent.new(id: 1) }

  describe "GET inxex" do
    let(:attendance_events) { build_stubbed_list(:attendance_event, 14) }

    before do
      sign_in(Admin.new)
      allow(AttendanceEvent)
        .to receive(:from_to).and_return(attendance_events)
    end

    context "when page[number] is present" do
      it "render the json with indicated page" do
        expect(controller).to receive(:render).with(
          json: attendance_events,
          links: {
            first: nil,
            last: nil,
            prev: "2019-01-01".to_date,
            next: "2019-01-29".to_date
          }
        ).and_call_original

        get :index, params: { page: { number: "2019-01-15" } }
      end
    end

    context "when page[number] is not present" do
      around do |example|
        Timecop.travel "02-01-2019" do
          example.run
        end
      end

      it "render the json with pate[number]=Time.zone.today" do
        expect(controller).to receive(:render).with(
          json: attendance_events,
          links: {
            prev: "2019-01-01".to_date,
            next: "2019-01-29".to_date,
            first: nil,
            last: nil
          }
        ).and_call_original

        get :index, params: { page: { number: "2019-01-15" } }
      end
    end

    include_examples "standard api create action",
      Api::V1::AttendanceEvents::CreateOperation
    include_examples "standard api update action",
      Api::V1::AttendanceEvents::UpdateOperation
    include_examples "standard api destroy action"
  end
end

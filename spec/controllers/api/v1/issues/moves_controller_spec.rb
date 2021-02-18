# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Issues::MovesController, type: :controller do
  subject(:post_request) do
    post :create, params: { issue_id: 1, before_issue_id: 2, board_list_id: 1 }
  end

  let(:user) { Admin.new  }

  before { sign_in(user) }

  describe "POST move" do
    context "when the operations succedes" do
      before do
        allow(Api::V1::Issues::MoveOperation).to receive(:call)
          .with(
            current_user: user,
            issue_id: "1",
            before_issue_id: "2",
            board_list_id: "1"
          )
          .and_return(Trailblazer::Operation::Result.new(true, issue: Issue.new(id: 1)))
      end

      it "renders status code 200" do
        post_request
        expect(response).to have_http_status(200)
      end
    end

    context "when the operations fails becuase of validation problems" do
      before do
        allow(Api::V1::Issues::MoveOperation).to receive(:call)
          .with(
            current_user: user,
            issue_id: "1",
            before_issue_id: "2",
            board_list_id: "1"
          )
          .and_return(Trailblazer::Operation::Result.new(false,
            form: double(failure?: true, errors: [])))
      end

      it "returns status code 400" do
        post_request
        expect(response).to have_http_status(400)
      end
    end

    context "when the operations fails becuase of permissions problems" do
      before do
        allow(Api::V1::Issues::MoveOperation).to receive(:call)
          .with(
            current_user: user,
            issue_id: "1",
            before_issue_id: "2",
            board_list_id: "1"
          )
          .and_return(Trailblazer::Operation::Result.new(false,
            form: double(failure?: false), pundit: false))
      end

      it "returns status code 401" do
        post_request
        expect(response).to have_http_status(401)
      end
    end
  end
end

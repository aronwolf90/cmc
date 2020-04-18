# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Issues::ClosesController, type: :controller do
  it "close" do
    sign_in(Admin.new)
    allow(Api::V1::Issues::CloseOperation).to receive(:call)
      .and_return(model: Issue.new(id: 1))

    post :create, params: { issue_id: 1 }
  end
end

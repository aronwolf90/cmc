# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::Issues::CommentsController, type: :controller do
  let(:model) { Comment.new(id: 1) }

  before { allow(Issue).to receive(:find).and_return(Issue.new(comments: [model])) }

  include_examples "standard api index action", params: { params: { issue_id: 1 } }
end

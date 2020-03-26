# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::Projects::ProjectCommentsController, type: :controller do
  let(:model) { ProjectComment.new(id: 1) }

  before do
    allow(Project).to receive(:find).and_return(Project.new(project_comments: [model]))
  end

  include_examples "standard api index action",
    params: { params: { project_id: 1  } }
end

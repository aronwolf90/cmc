# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::IssuesController, type: :controller do
  let(:model) { build_stubbed(:issue) }
  let(:form) { Administration::IssueForm }
  let(:params) { { board_list_id: model.board_list.id } }

  include_examples "standard show action", Administration::Issues
  include_examples "standard new action", Administration::Issues
  include_examples "standard create action", Administration::Issues, %i[administration board]
end

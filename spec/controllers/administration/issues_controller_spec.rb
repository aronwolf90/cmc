# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::IssuesController, type: :controller do
  let(:model) { build_stubbed(:issue) }
  let(:form) { Administration::IssueForm }

  include_examples "standard show action",
    Administration::Issues,
    params: { board_list_id: 1, id: 1 }
  include_examples "standard new action",
    Administration::Issues,
    params: { board_list_id: 1, id: 1 }
  include_examples "standard create action",
    Administration::Issues,
    %i[administration board],
    params: { board_list_id: 1 }
end

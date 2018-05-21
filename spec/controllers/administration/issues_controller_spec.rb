# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::IssuesController, type: :controller do
  let(:model) { build_stubbed(:issue) }
  let(:form) { Administration::IssuesForm }
  let(:params) { { board_list_id: model.board_list.id } }

  include_examples "standart new action", Administration::Issues
  include_examples "standart create action", Administration::Issues, %i[administration board]
end

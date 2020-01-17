# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Api::V1::Users::CurrentRecordsController, type: :controller do
  let(:model) { Record.new(id: 1) }
  let(:user) { User.new(id: 1) }

  before do
    allow(user).to receive(:current_record).and_return(model)
  end

  include_examples "simple api show action",
                   params: { user_id: 1 }
end

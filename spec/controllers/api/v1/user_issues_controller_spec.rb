# frozen_string_literal: true

require "rails_helper"
require_relative "./shared_examples/standart_actions"

RSpec.describe Api::V1::UserIssuesController, type: :controller do
  let(:model) { UserIssue.new }

  include_examples "standard api index action"
end


# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_show_operation"

RSpec.describe Administration::Issues::ShowOperation do
  let(:model) { Issue.new }

  it_should_behave_like "standard show operation"
end
#

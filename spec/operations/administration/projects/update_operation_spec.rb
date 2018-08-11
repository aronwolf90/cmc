# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_update_operation"

RSpec.describe Administration::Projects::UpdateOperation do
  subject { described_class.(params: params) }

  let(:project) { build_stubbed(:project) }

  before do
    allow(Project).to receive(:find).and_return(project)
  end

  it_should_behave_like "standard update operation",
    Administration::ProjectForm,
      {
        data: {
          name: "name"
        }
      },
      {
        data: {
          name: nil
        }
      }
end

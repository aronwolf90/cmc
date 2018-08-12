# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standard_update_operation"

RSpec.describe Administration::Organizations::UpdateOperation do
  let(:organization) { build_stubbed(:organization) }

  before do
    allow(Organization).to receive(:find_by)
      .and_return(organization)
  end

  it_should_behave_like "standard update operation",
    Administration::OrganizationForm,
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

# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::OrganizationsController, type: :controller do
  let(:model) { Organization.new(id: 1) }
  let(:form) { Administration::OrganizationForm }
  let(:params) { {} }

  include_examples "standard edit action", Administration::Organizations
  include_examples "standard update action", Administration::Organizations,
                   %i[edit administration organization]
end

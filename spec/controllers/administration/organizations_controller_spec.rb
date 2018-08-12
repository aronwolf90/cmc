# frozen_string_literal: true

require "rails_helper"
require_relative "../shared_examples/standart_actions"

RSpec.describe Administration::OrganizationsController, type: :controller do
  let(:model) { build_stubbed(:organization) }
  let(:form) { Administration::OrganizationForm }
  let(:params) { {} }

  include_examples "standart edit action", Administration::Organizations
  include_examples "standart update action", Administration::Organizations,
    %i[edit administration organization]
end

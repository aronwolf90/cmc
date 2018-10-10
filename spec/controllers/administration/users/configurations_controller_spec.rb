# frozen_string_literal: true

require "rails_helper"
require_relative "../../shared_examples/standart_actions"

RSpec.describe Administration::Users::ConfigurationsController, type: :controller do
  let(:model) { User.new(id: 1) }
  let(:form) { Administration::Users::ConfigurationForm }
  let(:params) { { user_id: model.id  } }

  include_examples "standard edit action",
    Administration::Users::Configurations,
    params: { user_id: 1 }
  include_examples "standard update action",
    Administration::Users::Configurations,
    "/administration/users/1/configuration/edit",
    params: { user_id: 1 }
  include_examples "standard destroy action",
    Administration::Users::Configurations,
    "/administration/users",
    params: { user_id: 1 }
end

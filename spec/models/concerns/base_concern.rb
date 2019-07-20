# frozen_string_literal: true

class BaseConcern
  include ActiveSupport::Concern

  def application_descendants; end
end

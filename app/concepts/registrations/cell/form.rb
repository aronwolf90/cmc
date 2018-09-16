# frozen_string_literal: true

module Registrations::Cell
  class Form < BaseFormCell
    def terms_service_label
      link_to " Terms of service", :terms
    end
  end
end

# frozen_string_literal: true

module Hack
  module KnockDevise
    module AuthTokenController
      extend ActiveSupport::Concern

      def entity_class
        User
      end
    end
  end
end

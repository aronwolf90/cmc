# frozen_string_literal: true

module Concerns
  module Transactional
    extend ActiveSupport::Concern

    included do
      class_attribute :transactional

      self.transactional = true
    end

    def run
      if self.class.transactional
        self.class.transaction do
          super
        end
      else
        super
      end
    end

    class_methods do
      def transaction
        ActiveRecord::Base.transaction do
          return yield
        end
      end
    end
  end
end

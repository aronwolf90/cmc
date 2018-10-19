# frozen_string_literal: true

module Api
  module V1
    class TreeSerializer < ApplicationSerializer
      def root
        object.root?
      end
    end
  end
end

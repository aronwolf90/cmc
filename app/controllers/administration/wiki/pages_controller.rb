# frozen_string_literal: true

module Administration
  module Wiki
    class PagesController < BaseController
      namespace Administration::WikiPages

      public :show, :new

      def create
        super { [:administration, :wiki] }
      end
    end
  end
end

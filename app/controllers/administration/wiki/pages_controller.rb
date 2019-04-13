# frozen_string_literal: true

module Administration
  module Wiki
    class PagesController < WikiController
      namespace Administration::WikiPages

      def show
        super
      end


      def new
        super
      end

      def create
        super { [:administration, :wiki, :content] }
      end
    end
  end
end

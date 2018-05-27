# frozen_string_literal: true

module Administration
  module Wiki
    class PagesController < WikiController
      include Concerns::Administration::StandardActions
      namespace WikiPages

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

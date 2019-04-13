# frozen_string_literal: true

module Administration
  module Archive
    module FoldersHelper
      include AdministrationHelper

      def cancel_btn
        super([:administration, :archive, :root])
      end

      def destroy_btn(folder)
        super([:archive, folder])
      end
    end
  end
end

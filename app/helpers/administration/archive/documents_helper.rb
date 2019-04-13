# frozen_string_literal: true

module Administration
  module Archive
    module DocumentsHelper
      include AdministrationHelper

      def cancel_btn
        super([:administration, :archive, :root])
      end

      def destroy_btn(document)
        super([:archive, document])
      end
    end
  end
end

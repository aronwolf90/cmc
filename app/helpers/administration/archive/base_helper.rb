# frozen_string_literal: true

module Administration
  module Archive
    module BaseHelper
      include AdministrationHelper

      def cancel_btn
        super(%i[administration archive])
      end

      def destroy_btn(document)
        super([:archive, document])
      end
    end
  end
end

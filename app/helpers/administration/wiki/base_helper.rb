# frozen_string_literal: true

module Administration
  module Wiki
    module BaseHelper
      include AdministrationHelper

      def cancel_btn
        super("/administration/wiki")
      end

      def destroy_btn(document)
        super([:archive, document])
      end
    end
  end
end

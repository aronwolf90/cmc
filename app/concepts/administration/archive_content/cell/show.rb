# frozen_string_literal: true

module Administration
  module ArchiveContent::Cell
    class Show < ApplicationCell
    private

      def add_folder_btn
        standard_btn "add folder", %i[new administration archive folder]
      end

      def add_document_btn
        standard_btn "add document", %i[new administration archive document]
      end
    end
  end
end

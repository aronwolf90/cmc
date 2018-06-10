# frozen_string_literal: true

module Administration
  module ArchiveContent::Cell
    class Show < ApplicationCell
    private

      def add_folder_btn
        link_to "add folder", %i[new administration archive folder],
          class: "btn btn-success"
      end

      def add_document_btn
        link_to "add document", %i[new administration archive document],
          class: "btn btn-success"
      end
    end
  end
end

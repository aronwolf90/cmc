# frozen_string_literal: true

module Administration
  class BaseArchiveCell < ApplicationCell
  private

    def cancell_btn
      link_to "Cancel", administration_archive_content_path,
        class: "btn btn-secondary pull-right"
    end
  end
end

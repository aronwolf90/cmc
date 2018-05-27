# frozen_string_literal: true

module Administration
  class Cell::BaseWiki < Cell::Application
  private

    def categories_collection
      WikiCategory.all.map do |category|
        [category, category.id]
      end
    end

    def cancell_btn
      link_to "Cancel", administration_wiki_content_path,
        class: "btn btn-secondary pull-right"
    end
  end
end

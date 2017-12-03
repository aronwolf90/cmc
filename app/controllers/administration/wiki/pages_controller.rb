module Administration::Wiki
  class PagesController < WikiController
    side_menu 'administration/wiki'

    def index
      run Page::Index

      render cell(Page::Cell::Index)
    end
  end
end

# frozen_string_literal: true

module Administration
  module BoardListsHelper
    include AdministrationHelper

    def destroy_btn(board_list)
      super(board_list, class: ("disabled" if board_list.issues.any?))
    end
  end
end

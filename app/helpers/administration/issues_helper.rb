# frozen_string_literal: true

module Administration
  module IssuesHelper
    include AdministrationHelper

    def cancel_btn
      super("/administration/board_lists")
    end
  end
end

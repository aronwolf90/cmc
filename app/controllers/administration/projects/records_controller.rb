# frozen_string_literal: true

module Administration
  module Projects
    class RecordsController < BaseController
      include RecordsControllerConcern
      namespace Administration::Projects::Records
    end
  end
end

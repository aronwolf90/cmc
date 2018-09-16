# frozen_string_literal: true

module Administration
  module Users
    class RecordsController < BaseController
      include RecordsControllerConcern
      namespace Administration::Users::Records
    end
  end
end

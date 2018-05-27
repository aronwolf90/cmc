# frozen_string_literal: true

module Administration
  module WikiPages
    class ShowOperation < AdministrationOperation
      step Model(WikiPage, :find)
    end
  end
end

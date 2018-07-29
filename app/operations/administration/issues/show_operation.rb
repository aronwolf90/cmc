# frozen_string_literal: true

module Administration
  module Issues
    class ShowOperation < AdministrationOperation
      step Model(Issue, :find)
    end
  end
end

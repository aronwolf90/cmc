# frozen_string_literal: true

module Administration
  module WikiPages
    class ShowOperation < AdministrationOperation
      step Model(WikiPage, :find)
      step Policy::Pundit(WikiPagePolicy, :show?)
    end
  end
end

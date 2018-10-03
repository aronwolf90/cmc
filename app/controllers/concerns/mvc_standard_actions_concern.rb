# frozen_string_literal: true

module MvcStandardActionsConcern
  include MvcNoModifyStandardActionsConcern
  include MvcModifyStandardActionsConcern

private

  def action_or_form(action)
    "#{namespace}::Cell::#{action}".try_constanize ||
      "#{namespace}::Cell::Form".constantize
  end
end

# frozen_string_literal: true

class IndexParentModelStep < ApplicationStep
  pattr_initialize %i[relation]

  def call(options, parent:, **)
    options[:model] = parent.public_send(relation)
  end
end

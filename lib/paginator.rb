# frozen_string_literal: true

class Paginator
  def self.call(model, page)
    model.page(page || 1).per(5)
  end
end

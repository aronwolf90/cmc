# frozen_string_literal: true

module I18n
  class << self
    def localize(text, options = {})
      super if text
    end

    alias_method :l, :localize
  end
end

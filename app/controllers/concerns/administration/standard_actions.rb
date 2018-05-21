# frozen_string_literal: true

module Concerns
  module Administration
    module StandardActions
      include NoModifyStandardActions
      include ModifyStandardActions
    end
  end
end

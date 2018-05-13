# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  include Concerns::Transactional
end

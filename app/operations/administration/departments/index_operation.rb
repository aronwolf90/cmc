# frozen_string_literal: true

module Administration::Departments
  class IndexOperation < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options["model"] = ::Department.all
    end
  end
end

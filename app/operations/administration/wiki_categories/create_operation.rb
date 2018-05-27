# frozen_string_literal: true

module Administration
  module WikiCategories
    class CreateOperation < AdministrationOperation
      class Present < Trailblazer::Operation
        step Model(WikiCategory, :new)
        step Contract::Build(constant: WikiCategoryForm)
      end

      step Nested(Present)
      step Contract::Validate(key: :data)
      step Contract::Persist()
    end
  end
end

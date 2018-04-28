# frozen_string_literal: true

module Administration
  module Records
    class DestroyOperation < AdministrationOperation
      step Model(Record, :find)
      step :delete!

      def delete!(options, model:, **)
        model.destroy!
      end
    end
  end
end

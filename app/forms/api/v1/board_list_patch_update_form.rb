module Api
  module V1
    class BoardListPatchUpdateForm < PatchUpdateBaseForm
      clazz BoardList
      associations %i[issues]

      attributes :name, :ordinal_number

      validates :name, presence: true
      validates :ordinal_number, presence: true
    end
  end
end

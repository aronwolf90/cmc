module Board
  class Contract < Reform::Form
    property :issue, validates: { presence: true } do
      property :project, validates: { absence: true }
    end

    property :dasboard_status, validates: { presence: true } do
      property :project, validates: { absence: true }
    end
  end
end

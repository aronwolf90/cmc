# frozen_string_literal: true

ProjectBoardList.bulk_insert(
  :id,
  :name,
  :project_status_id,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "New",
    project_status_id: 1
  )

  worker.add(
    id: 2,
    name: "In contact",
    project_status_id: 1
  )

  worker.add(
    id: 3,
    name: "In revision",
    project_status_id: 1
  )

  worker.add(
    id: 4,
    name: "Default",
    project_status_id: 2
  )

  worker.add(
    id: 5,
    name: "Default",
    project_status_id: 3
  )
end

# frozen_string_literal: true

Project.bulk_insert(
  :id, 
  :name, 
  :description, 
  :project_board_list_id,
  :ordinal_number,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "Test project",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 0,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    name: "Test project 2",
    description: "Test description",
    project_board_list_id: 2,
    ordinal_number: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 3,
    name: "Test project 3",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 2,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 4,
    name: "Test project 4",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 3,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 5,
    name: "Test project 5",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 4,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 6,
    name: "Test project 6",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 5,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 7,
    name: "Test project 7",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 6,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 8,
    name: "Test project 8",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 7,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 9,
    name: "Test project 9",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 8,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 10,
    name: "Test project 10",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 9,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 11,
    name: "Test project 11",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 10,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 12,
    name: "Test project 12",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 11,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 13,
    name: "Test project 13",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 12,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 14,
    name: "Test project 14",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 13,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 15,
    name: "Test project 15",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 14,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 16,
    name: "Test project 16",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 15,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 17,
    name: "Test project 17",
    description: "Test description",
    project_board_list_id: 1,
    ordinal_number: 16,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

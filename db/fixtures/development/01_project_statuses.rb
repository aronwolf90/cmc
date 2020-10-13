# frozen_string_literal: true

ProjectStatus.bulk_insert(
  :id,
  :name,
  :initial,
  :display_as,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "New",
    initial: true,
    display_as: "board",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    name: "Active",
    initial: false,
    display_as: "list",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 3,
    name: "Archived",
    initial: false,
    display_as: "list",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

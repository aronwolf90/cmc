# frozen_string_literal: true

Label.bulk_insert(
  :id,
  :name,
  :color,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "Bug",
    color: "#ff0000",
    created_at: Time.zone.now,
    updated_At: Time.zone.now
  )

  worker.add(
    id: 2,
    name: "Important",
    color: "#ff0000",
    created_at: Time.zone.now,
    updated_At: Time.zone.now
  )
end

IssueLabel.seed do |s|
  s.label_id = 1
  s.issue_id = 1
end

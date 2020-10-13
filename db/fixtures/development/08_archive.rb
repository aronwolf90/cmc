# frozen_string_literal: true

Folder.bulk_insert(
  :id,
  :name,
  :project_id,
  :folder_id,
  :created_at,
  :updated_at
) do |worker|
  worker.add(
    id: 1,
    name: "Test project",
    project_id: 1,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 2,
    name: "Test project 1",
    project_id: 2,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 3,
    name: "folder 1",
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 4,
    name: "folder 2",
    folder_id: 3,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 5,
    name: "Test project 3",
    project_id: 3,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 6,
    name: "Test project 4",
    project_id: 4,
  )

  worker.add(
    id: 7,
    name: "Test project 5",
    project_id: 5,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 8,
    name: "Test project 6",
    project_id: 6,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 9,
    name: "Test project 7",
    project_id: 7,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 10,
    name: "Test project 8",
    project_id: 8,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 11,
    name: "Test project 9",
    project_id: 9,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 12,
    name: "Test project 10",
    project_id: 10,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 13,
    name: "Test project 11",
    project_id: 11,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 14,
    name: "Test project 12",
    project_id: 12,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 15,
    name: "Test project 13",
    project_id: 13,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 16,
    name: "Test project 14",
    project_id: 14,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 17,
    name: "Test project 15",
    project_id: 15,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 18,
    name: "Test project 15",
    project_id: 16,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )

  worker.add(
    id: 19,
    name: "Test project 15",
    project_id: 17,
    created_at: Time.zone.now,
    updated_at: Time.zone.now
  )
end

# id 1
DocumentFiles::CreateMutation.call(
  model: DocumentFile.new,
  file: Rack::Test::UploadedFile.new(
    Rails.root.join("spec", "fixtures", "document.txt")
  )
)

# id 2
DocumentFiles::CreateMutation.call(
  model: DocumentFile.new,
  file: Rack::Test::UploadedFile.new(
    Rails.root.join("spec", "fixtures", "document.txt")
  )
)

# id 3
DocumentFiles::CreateMutation.call(
  model: DocumentFile.new,
  file: Rack::Test::UploadedFile.new(
    Rails.root.join("spec", "fixtures", "document.txt")
  )
)

Document.seed do |s|
  s.id               = 1
  s.folder_id        = 1
  s.name             = "Document 1"
  s.document_file_id = 1
end

Document.seed do |s|
  s.id               = 2
  s.folder_id        = 2
  s.name             = "Document 2"
  s.document_file_id = 2
end

Document.seed do |s|
  s.id               = 3
  s.folder_id        = 3
  s.name             = "Document 2"
  s.document_file_id = 2
end

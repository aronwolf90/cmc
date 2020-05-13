# frozen_string_literal: true

Folder.seed do |s|
  s.id         = 1
  s.name       = "Test project"
  s.project_id = 1
end

Folder.seed do |s|
  s.id         = 2
  s.name       = "Test project 1"
  s.project_id = 2
end

Folder.seed do |s|
  s.id   = 3
  s.name = "folder 1"
end

Folder.seed do |s|
  s.id        = 4
  s.name      = "folder 2"
  s.folder_id = 3
end

Folder.seed do |s|
  s.id         = 5
  s.name       = "Test project 3"
  s.project_id = 3
end

Folder.seed do |s|
  s.id         = 6
  s.name       = "Test project 4"
  s.project_id = 4
end

Folder.seed do |s|
  s.id         = 7
  s.name       = "Test project 5"
  s.project_id = 5
end

Folder.seed do |s|
  s.id         = 8
  s.name       = "Test project 6"
  s.project_id = 6
end

Folder.seed do |s|
  s.id         = 9
  s.name       = "Test project 7"
  s.project_id = 7
end

Folder.seed do |s|
  s.id         = 10
  s.name       = "Test project 8"
  s.project_id = 8
end

Folder.seed do |s|
  s.id         = 11
  s.name       = "Test project 9"
  s.project_id = 9
end

Folder.seed do |s|
  s.id         = 12
  s.name       = "Test project 10"
  s.project_id = 10
end

Folder.seed do |s|
  s.id         = 13
  s.name       = "Test project 11"
  s.project_id = 11
end

Folder.seed do |s|
  s.id         = 14
  s.name       = "Test project 12"
  s.project_id = 12
end

Folder.seed do |s|
  s.id         = 15
  s.name       = "Test project 13"
  s.project_id = 13
end

Folder.seed do |s|
  s.id         = 16
  s.name       = "Test project 14"
  s.project_id = 14
end

Folder.seed do |s|
  s.id         = 17
  s.name       = "Test project 15"
  s.project_id = 15
end

Folder.seed do |s|
  s.id         = 18
  s.name       = "Test project 15"
  s.project_id = 16
end

Folder.seed do |s|
  s.id         = 19
  s.name       = "Test project 15"
  s.project_id = 17
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

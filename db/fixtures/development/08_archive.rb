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

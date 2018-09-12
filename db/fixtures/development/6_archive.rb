# frozen_string_literal: true

Folder.seed do |s|
  s.id   = 1
  s.name = "folder 1"
end

Document.seed do |s|
  s.id        = 1
  s.folder_id = 1
  s.name      = "Document 1"
  s.file      = File.open(Rails.root.join("spec", "fixures", "document.txt"))
end

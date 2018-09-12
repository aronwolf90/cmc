# frozen_string_literal: true

path = Rails.root.join("db", "fixtures", "development", "*.rb")

Dir[path].sort.each do |file|
  load file
end

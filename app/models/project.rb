class Project < ApplicationRecord
  alias_attribute :to_s, :name
end

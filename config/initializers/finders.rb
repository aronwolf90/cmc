# frozen_string_literal: true

require Rails.root.join("lib", "finders", "mutation_finder")

def mutation(model, name)
  MutationFinder.new(model, name).call
end

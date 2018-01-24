module Administration::Project
  class Show < Trailblazer::Operation
    step Model(Project, :find_by)
  end
end

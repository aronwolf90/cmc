module Administration::Project
  class Index < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options['model'] = ::Project.all
    end
  end
end

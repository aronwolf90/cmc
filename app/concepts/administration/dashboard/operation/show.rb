module Administration::Dashboard
  class Show < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options['model'] = ::Issue.all
    end
  end
end

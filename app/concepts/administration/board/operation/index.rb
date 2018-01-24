module Administration::Board
  class Show < Trailblazer::Operation
    step :issues!

    def issues!(options, *)
      options['issues'] = ::Issue.all
    end
  end
end

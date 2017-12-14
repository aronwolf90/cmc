module Administration::BoardList
  class Index < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options['model'] = Representer.for_collection.prepare(BoardList.all)
    end
  end
end

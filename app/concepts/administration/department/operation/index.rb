module Administration::Department
  class Index < Trailblazer::Operation
    step :model!

    def model!(options, *)
      options['model'] = ::Department.all
    end
  end
end

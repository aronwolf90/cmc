# frozen_string_literal: true

module MvcNoModifyStandardActionsConcern
  protected
    def index(view_options: [])
      result = run namespace::IndexOperation
      set_view_options(view_options)
      @model = result[:model] || result["model"]
    end

    def new(render: :form)
      result = run namespace::NewOperation
      @model = result["contract.default"]
      render(render)
    end

    def show(view_options: [])
      result = run namespace::ShowOperation
      set_view_options(view_options)
      @model ||= result[:model] || result["model"]
    end

    def edit(render: :form)
      result = run namespace::UpdateOperation::Present
      @model = result["contract.default"]
      render(render)
    end

    def set_view_options(view_options)
      view_options.each do |option|
        instance_variable_set(
          "@#{option}",
          result[option.to_sym] || result[option.to_s]
        )
      end
    end
end

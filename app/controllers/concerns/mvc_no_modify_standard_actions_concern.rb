# frozen_string_literal: true

module MvcNoModifyStandardActionsConcern
  protected
    def index(view_options: [])
      result = run namespace::IndexOperation
      set_view_options(view_options)
      @model = result[:model] || result["model"]
      if request.headers["LAYOUT"] == "false"
        render "no_layout_index", layout: false
      end
    end

    def new(render: :form)
      result = run namespace::NewOperation
      @model = result["contract.default"]
      if request.headers["LAYOUT"] == "false"
        render("no_layout_#{render}", layout: false)
      else
        render(render)
      end
    end

    def show(view_options: [])
      result = run namespace::ShowOperation
      set_view_options(view_options)
      @model ||= result[:model] || result["model"]
      if request.headers["LAYOUT"] == "false"
        render "no_layout_show", layout: false
      end
    end

    def edit(render: :form)
      result = run namespace::UpdateOperation::Present
      @model = result["contract.default"]
      if request.headers["LAYOUT"] == "false"
        render("no_layout_#{render}", layout: false)
      else
        render(render)
      end
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

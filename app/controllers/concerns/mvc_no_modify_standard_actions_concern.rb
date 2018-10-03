# frozen_string_literal: true


module MvcNoModifyStandardActionsConcern
protected

  def index(cell_options: [])
    result = run namespace::IndexOperation
    render_info_cell(namespace::Cell::Index, result, cell_options)
  end

  def new
    result = run namespace::CreateOperation::Present
    render cell(
      action_or_form("Create"),
      result["contract.default"]
    )
  end

  def show(cell_options: [])
    result = run namespace::ShowOperation
    render_info_cell(namespace::Cell::Show, result, cell_options)
  end

  def edit
    result = run namespace::UpdateOperation::Present
    render cell(
      action_or_form("Update"),
      result["contract.default"]
    )
  end

  def render_info_cell(cell_class, result, cell_options)
    render cell(cell_class, result["model"] || result[:model], slice(result, cell_options))
  end

  def slice(result, options)
    options.map do |option|
      [option, result[option]]
    end.to_h
  end
end

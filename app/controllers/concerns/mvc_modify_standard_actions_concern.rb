# frozen_string_literal: true

module MvcModifyStandardActionsConcern
protected
  def create(&block)
    result = saved(namespace::CreateOperation, "Create", :created, block)
  end

  def update(&block)
    result = saved(namespace::UpdateOperation, "Update", :updated, block)
  end

  def destroy(path)
    result = run namespace::DestroyOperation
    redirect_to path, notice: "#{model_name(result)} has been destroyed"
  end

  def saved(operation, action, type, block)
    run operation do |result|
      flash[:notice] = "#{model_name(result)} has been #{type}"
      return redirect_to block.call(result[:model])
    end

    render cell(
      action_or_form(action),
      result["contract.default"]
    )
  end

  def model_name(result)
    result["contract.default"].class.model_name.human
  end

  def action_or_form(action)
    "#{namespace}::Cell::#{action}".try_constanize ||
      "#{namespace}::Cell::Form".constantize
  end
end

# frozen_string_literal: true

module MvcModifyStandardActionsConcern
protected
  def create(render: :form, &block)
    result = saved(namespace::CreateOperation, "Create", :created, render, block)
  end

  def update(render: :form, &block)
    saved(namespace::UpdateOperation, "Update", :updated, render, block)
  end

  def destroy(path)
    result = run namespace::DestroyOperation
    redirect_to path, notice: "#{model_name(result)} has been destroyed"
  end

  def saved(operation, action, type, render, block)
    run operation do |result|
      flash[:notice] = "#{model_name(result)} has been #{type}"
      return redirect_to block.call(result[:model])
    end

    @model = result["contract.default"]
    render(render)
  end

  def model_name(result)
    (result[:model] || result["model"]).class.model_name.human
  end
end

# frozen_string_literal: true

require "uri"

module AdministrationHelper
  include ApplicationHelper

  def new_btn(clazz)
    super(*transformation(clazz, action: :new))
  end

  def edit_btn(object)
    super(*transformation(object, action: :edit))
  end

  def csv_btn(clazz)
    super(*transformation(clazz))
  end

  def link(object)
    super(*transformation(object))
  end

  def edit_link(object)
    super(*transformation(object, action: :edit))
  end

private

  def transformation(object, action: nil)
    path = %i[administration] + Array(object)
    [path.last, create_url(action, path)]
  end

  def create_url(action, path)
    method = (Array(action) + ["polymorphic_path"]).join("_")
    send(method, path)
  end
end

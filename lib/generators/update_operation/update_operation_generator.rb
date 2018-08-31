# frozen_string_literal: true

class UpdateOperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  check_class_collision suffix: "Operation"

  def create_operation
    path = File.join("app", "operations",
      class_path, file_name.pluralize, "update.rb")

    template("operation.rb.erb", path)
  end

  def create_spec
    path = File.join("spec", "operations", class_path,
      file_name.pluralize, "update_spec.rb")

    template("spec.rb.erb", path)
  end
end

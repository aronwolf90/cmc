# frozen_string_literal: true

class CreateOperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  check_class_collision suffix: "Operation"

  def create_operation
    file = File.join("app", "operations", class_path,
      file_name.pluralize, "create.rb")

    template("operation.rb.erb", file)
  end

  def create_spec
    file = File.join("spec", "operations", class_path,
      file_name.pluralize, "create_spec.rb")

    template("spec.rb.erb", file)
  end
end

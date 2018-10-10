# frozen_string_literal: true

class DestroyOperationGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  check_class_collision suffix: "Operation"

  def destroy_operation
    file = File.join("app", "operations", class_path,
      file_name.pluralize, "destroy.rb")

    template("operation.rb.erb", file)
  end

  def destroy_spec
    file = File.join("spec", "operations", class_path,
      file_name.pluralize, "destroy_spec.rb")

    template("spec.rb.erb", file)
  end
end

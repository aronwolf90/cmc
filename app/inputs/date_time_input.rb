# frozen_string_literal: true

class DateTimeInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = {})
    wrapper_options[:autocomplete] = "off"
    input_html_classes << "datetimepicker"
    value = object.send(attribute_name)
    options[:value] = I18n.l value if value.present?
    super
  end
end

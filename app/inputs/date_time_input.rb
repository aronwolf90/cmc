# frozen_string_literal: true

class DateTimeInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = {})
    wrapper_options[:autocomplete] = "off"
    input_html_classes << "datetimepicker"
    options[:value] = I18n.l object.send(attribute_name)
    super
  end
end

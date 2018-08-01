# frozen_string_literal: true

class ImagePreviewInput < SimpleForm::Inputs::FileInput
  def input(_wrapper_options = nil)
    out = ""
    out += template.image_tag(url, class: "img-thumbnail") if url
    out += @builder.input(attribute_name, as: "hidden")
    out += @builder.input("#{attribute_name}_cache", as: "hidden")
    (out += super).html_safe
  end

private

  def url
    @url ||=
      if @builder.object.send(attribute_name).respond_to?(:url)
        @builder.object.send(attribute_name).url
      end
  end
end

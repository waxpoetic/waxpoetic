# Adds some sane defaults to make CarrierWave interaction with jQuery
# File Upload a bit easier.
class MultiFileInput < SimpleForm::Inputs::FileInput
  def input_html_options
    super.merge multiple: true
  end

  def attribute_name
    "#{object_name}[#{column_name}]"
  end
end

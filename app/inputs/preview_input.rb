class PreviewInput < SimpleForm::Inputs::Base
  def input
    @builder.text_area(attribute_name).concat(preview)
  end

  private
  def preview
    %{<div style="clear:both"></div><div class="rendered-html"><div class="empty">Loading preview...</div></div>}.html_safe
  end
end

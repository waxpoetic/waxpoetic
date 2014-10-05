module MarkdownHelper
  # Render markdown.
  def markdown(text)
    markdown_parser.render text
  end

  private
  def markdown_parser
    Redcarpet::Markdown.new markdown_renderer, autolink: true
  end

  def markdown_renderer
    Redcarpet::Render::HTML.new filter_html: true
  end
end

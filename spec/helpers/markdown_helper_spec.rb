require 'rails_helper'

RSpec.describe MarkdownHelper, type: :helper do
  it 'renders markdown' do
    expect(helper.markdown('**bold text**')).to match('<strong>bold text</strong>')
  end

  it 'defines a markdown parser' do
    expect(helper.send(:markdown_parser)).to be_a(Redcarpet::Markdown)
  end

  it 'defines a markdown renderer' do
    expect(helper.send(:markdown_renderer)).to be_a(Redcarpet::Render::HTML)
  end
end

module TitleHelper
  def title_tag
    content_tag :title, title_text.html_safe
  end

  def title(new_title="", cosmetic: nil)
    content_for :title, new_title
    content_tag :h1, class: 'title' do
      cosmetic || new_title
    end
  end

  private
  def title_text
    if page_has_title?
      "#{page_title} | #{site_title}"
    else
      site_title
    end
  end

  def site_title
    "Wax Poetic Records"
  end

  def page_title
    content_for :title
  end

  def page_has_title?
    content_for? :title
  end
end

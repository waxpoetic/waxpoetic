class EventDecorator < Draper::Decorator
  delegate_all

  DATE_DISPLAY = '%A, %B %e, %Y at %l:%M %p'

  def description
    h.markdown description
  end

  def gallery_description
    h.strip_tags description
  end

  def flyer_tag
    h.image_tag model.flyer, alt: model.name
  end

  def time
    if ends?
      "from #{starts_at} to #{ends_at}".html_safe
    else
      starts_at.html_safe
    end
  end

  def buy_tickets_button
    h.link_to "Buy Tickets", model.product, class: 'button success'
  end

  private
  def ends?
    model.ends_at.present?
  end

  [:starts_at, :ends_at].each do |date_method|
    define_method date_method do
      model.send(date_method).strftime DATE_DISPLAY
    end
  end
end

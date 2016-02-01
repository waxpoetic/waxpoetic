class CollectionDecorator < Draper::CollectionDecorator
  delegate :per_page, :current_page, :page
end

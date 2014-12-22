require 'wax_poetic/product'

class ReleaseProduct < WaxPoetic::Product
  metadata_field :catalog_number
  metadata_field :release_date

  def name
    saleable.decorate.title
  end

  def description
    saleable.full_description
  end

  def available_on
    saleable.released_on
  end
end

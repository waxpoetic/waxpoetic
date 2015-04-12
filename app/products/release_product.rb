# Product decorator for Releases. Adds metadata fields like the catalog
# number and date of release, which is typically the same as the
# available_on parameter (but not shown).
class ReleaseProduct < WaxPoetic::Product
  metadata_field :catalog_number
  metadata_field :release_date

  def name
    saleable.title
  end

  def description
    saleable.full_description
  end

  def available_on
    saleable.released_on
  end
end

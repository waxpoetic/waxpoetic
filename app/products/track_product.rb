# Product presenter for Tracks, which delegate catalog numbers and
# release dates to the Release.
class TrackProduct < WaxPoetic::Product
  metadata_field :catalog_number
  metadata_field :release_date

  def name
    saleable.decorate.title
  end

  def available_on
    saleable.decorate.release_date
  end
end

# Release catalog of the record label, sorted by artist.

class Release < ActiveRecord::Base
  belongs_to :artist
  belongs_to :product

  has_many :tracks

  before_validation :calculate_price_from_tracks

  validates :name, presence: true
  validates :released_on, presence: true
  validates :description, presence: true
  validates :catalog_number, presence: true
  validates :price, presence: true
  validates :artist, presence: true

  after_create :create_product_and_variants,
               :create_and_upload_package,
               :send_promotional_emails

  mount_uploader :cover, ImageUploader
  mount_uploader :package, PackageUploader

  delegate :variants, :to => :product

  # Attributes given to the Spree::Product when created.
  def product_attributes
    {
      name: self.decorate.title,
      description: description,
      permalink: self.decorate.permalink,
      available_on: released_on,
      meta_description: description
    }
  end

  private
  def calculate_price_from_tracks
    self.price ||= tracks.sum(:price)
  end

  def create_product_and_variants
    CreateReleaseProduct.enqueue self
  end

  def create_package
    PackageRelease.enqueue self
  end

  def send_promotional_emails
    PromoteRelease.enqueue self if released_on == Date.today
  end
end

# ## Schema Information
#
# Table name: `releases`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `integer`          | `not null, primary key`
# **`name`**            | `string(255)`      |
# **`artist_id`**       | `integer`          |
# **`released_on`**     | `datetime`         |
# **`cover`**           | `string(255)`      |
# **`description`**     | `text`             |
# **`catalog_number`**  | `string(255)`      |
# **`created_at`**      | `datetime`         |
# **`updated_at`**      | `datetime`         |
# **`price`**           | `decimal(19, 2)`   |
# **`package`**         | `string(255)`      |
#
# ### Indexes
#
# * `index_releases_on_artist_id`:
#     * **`artist_id`**
#

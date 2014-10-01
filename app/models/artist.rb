class Artist < ActiveRecord::Base
  has_many :releases

  validates :name, presence: true
  validates :bio, presence: true

  mount_uploader :avatar, ImageUploader
end

# ## Schema Information
#
# Table name: `artists`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`bio`**         | `text`             |
# **`avatar`**      | `string(255)`      |
# **`created_at`**  | `datetime`         |
# **`updated_at`**  | `datetime`         |
#

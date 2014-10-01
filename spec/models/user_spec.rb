# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `inet`             |
# **`last_sign_in_ip`**         | `inet`             |
# **`created_at`**              | `datetime`         |
# **`updated_at`**              | `datetime`         |
# **`is_admin`**                | `boolean`          | `default(FALSE)`
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  subject do
    User.new \
      email: 'user@example.com',
      password: 'password1',
      password_confirmation: 'password1'
  end

  it "authenticates users into the admin console" do
    expect(subject).to be_valid
  end

  it "is not an admin by default" do
    expect(subject).to_not be_admin
  end

  it "can have admin rights changed on it" do
    subject.is_admin = true
    expect(subject).to be_admin
  end
end

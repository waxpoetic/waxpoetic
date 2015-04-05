# A generic registered user on this application. This data model powers
# Devise and Warden, which are the authentication engines we delegate to
# when we need to protect certain functions of the site.
class User < ActiveRecord::Base
  include Authority::UserAbilities
  include SpreeUserExtensions

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, email: true

  scope :admins, -> { joins(:spree_roles).where(spree_roles: { name: 'admin' }) }

  after_commit :subscribe_to_newsletter

  # Create a new admin user by assigning it the 'admin' role in Spree.
  # We use this role to identify admin users in the frontend catalog app
  # as well.
  def self.create_admin(options={})
    user = create(options)
    user.spree_roles << Spree::Role.find_or_create_by(name: "admin")
    user.save
    user
  end

  # Test if this user has the admin role assigned to it.
  def admin?
    has_spree_role? 'admin'
  end

  private

  def subscribe_to_newsletter
    Subscriber.create name: name, email: email
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  spree_api_key          :string(48)
#  ship_address_id        :integer
#  bill_address_id        :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

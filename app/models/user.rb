class User < ActiveRecord::Base
  attr_accessor :is_admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :assign_admin_roles, :if => :is_admin

  scope :admins, -> { joins(:spree_roles).where(spree_roles: { name: 'admin' }) }

  validates :email, presence: true, email: true

  # Test if this user has the admin role assigned to it.
  def admin?
    has_spree_role? 'admin'
  end

  private
  def assign_admin_roles
    self.spree_roles << Spree::Role.find_or_create_by(name: "admin")
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

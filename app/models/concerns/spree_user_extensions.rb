module SpreeUserExtensions
  extend ActiveSupport::Concern

  include Spree::UserApiAuthentication
  include Spree::UserPaymentSource
  include Spree::UserReporting

  included do
    has_and_belongs_to_many :spree_roles,
                            join_table: 'spree_roles_users',
                            foreign_key: "user_id",
                            class_name: "Spree::Role"

    has_many :orders, foreign_key: :user_id, class_name: "Spree::Order"

    belongs_to :ship_address, class_name: 'Spree::Address'
    belongs_to :bill_address, class_name: 'Spree::Address'
  end

  # has_spree_role? simply needs to return true or false whether a user has a role or not.
  def has_spree_role?(role_in_question)
    spree_roles.where(name: role_in_question.to_s).any?
  end

  def last_incomplete_spree_order
    orders.incomplete.order('created_at DESC').first
  end
end

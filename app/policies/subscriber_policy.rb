class SubscriberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes
    [:name, :email]
  end
end

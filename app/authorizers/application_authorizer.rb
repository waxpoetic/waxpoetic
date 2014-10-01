# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer
  # Generally, we prefer only admins to edit any new features, unless
  # the subclass authorizer is going to override this or any other
  # method for some other reason (such as ownership). But for now,
  # admins are the only ones that can edit everything.
  #
  # A sidenote...this also controls readability, which by default
  # everything is public...
  def self.default(adjective, user)
    return true if adjective == :readable
    user.admin?
  end
end

# The Wax Poetic Records official site.
module WaxPoetic
  # Normally somewhat cumbersome to type out, this shorthand gives
  # quick access to the app secret keys so you can use them in
  # credentials throughout the app.
  def self.secrets
    Rails.application.secrets
  end

  # The +SemVer+ object that represents the current version string.
  #
  # @return [SemVer]
  def self.version
    @version ||= SemVer.find
  end
end

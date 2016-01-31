# Library code for the Wax Poetic Records official site. All code in
# this directory is included in the application's +$LOAD_PATH+ at boot
# time, and this particular base module is required in as the
# application is defined. The code contained in +lib/wax_poetic+ is not
# meant to be auto-loaded into the rest of the application. Instead, it
# is for code that doesn't need to be used *all* the time, and meant for
# functionality that will be required in manually. For this reason, the
# tests in +spec/lib/wax_poetic+ do not load the Rails application. This
# is to maintain decoupling between the actual app and its library code.
module WaxPoetic
  # Normally somewhat cumbersome to type out, this shorthand gives
  # quick access to the app secret keys so you can use them in
  # credentials throughout the app.
  #
  # @return [Rails::Configuration]
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

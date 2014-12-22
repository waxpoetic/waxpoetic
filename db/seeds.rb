require 'active_record/fixture_set'

# Automatically loads data from the fixtures directory into the
# 'development' database. Allows for faster "spin-up" of the database.
# The seeds file can also be appended with some custom configuration,
# such as a default User. An example way of doing this has been
# commented out at the bottom of this file.
#
# It is recommended that fixtures are used to seed the database for both
# the 'development' and 'test' environments, or environments which take
# on characteristics of the aforementioned. This is so we can keep seed
# data in one place, and reduce the amount of duplication throughout the
# codebase.

ActiveRecord::Base.transaction do
  # Build as many objects as we can from fixtures.
  ActiveRecord::FixtureSet.create_fixtures "spec/fixtures", WaxPoetic.config.seed_tables

  # Stand up Spree data.
  Spree::Core::Engine.load_seed if defined? Spree::Core
  Spree::Auth::Engine.load_seed if defined? Spree::Auth

  # Include additional data from flat file configuration.
  WaxPoetic::Seed.load!
end

require 'rails/generators/rails/resource/resource_generator'

using ResourceGeneratorRefinement

Rails.application.config.generators do |g|
  g.test_framework :rspec, fixtures: true, fixture_location: 'spec/fixtures'
  g.stylesheet_engine :sass
  g.javascript_engine :coffee
  g.helper false
end

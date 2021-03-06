# Allows this model to be exported in full to a fixture file.
module Exportable
  extend ActiveSupport::Concern

  def self.models
    ActiveRecord::Base.descendants.select do |model|
      model.included_modules.include?(Exportable)
    end.map { |model| model.name.constantize }
  end

  module ClassMethods
    def to_fixture
      File.write fixture_path, fixture_contents.to_yaml
    end

    private

    def fixture_path
      "#{Rails.root}/spec/fixtures/#{table_name}.yml"
    end

    def fixture_contents
      all.reduce({}) do |contents, model|
        contents.merge(model.yaml_param => model.attributes)
      end
    end
  end

  def yaml_param
    name.parameterize.underscore
  end
end

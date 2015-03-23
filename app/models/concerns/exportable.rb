# Allows this model to be exported in full to a fixture file.
module Exportable
  extend ActiveSupport::Concern

  module ClassMethods
    def export_to_fixtures
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

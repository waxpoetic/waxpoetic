module LegacyExport
  extend ActiveSupport::Concern

  included do
    cattr_accessor :_exports, :new_table_name
    self.new_table_name = self.table_name
    self.table_name = "legacy_#{self.new_table_name}"
  end

  module ClassMethods

    def export!
      File.write "#{Rails.root}/spec/fixtures/#{new_table_name}.yml", exports
    end

    def exports
      all.reduce({}) { |hash, model|
        hash[model.yaml_param] = model.exports
        hash
      }.to_yaml
    end

    def export(attribute, method = nil)
      method ||= attribute
      self._exports ||= {}
      self._exports[attribute] = method
    end
  end

  def yaml_param
    name.parameterize.underscore.singularize
  end

  def exports
    self.class._exports.reduce({}) do |hash, (attribute, method)|
      hash.merge attribute.to_s => send(method)
    end
  end
end

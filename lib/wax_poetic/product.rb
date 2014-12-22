module WaxPoetic
  class Product
    include ActiveModel::Model

    cattr_accessor :metadata_fields
    attr_accessor :saleable

    # Add a new metadata field to the hash. Define the attribute that is
    # to be fetched from the saleable record's decorator.
    def self.metadata_field(attr_name)
      @metadata_fields ||= []
      @metadata_fields << attr_name
    end

    def name
      saleable.name
    end

    def description
      saleable.description
    end

    def meta_description
      saleable.description
    end

    def available_on
      saleable.created_at
    end

    def image
      File.open(saleable.image.file.file)
    end

    def price
      saleable.price
    end

    # Use the default shipping category in Spree.
    def shipping_category
      Spree::ShippingCategory.find_by_name 'Default'
    end

    # Hash of metadata compiled from each `metadata_field` entry. This
    # wil be an empty Hash if no metadata_fields were defined.
    def metadata
      self.class.metadata_fields.each_with_index.reduce({}) do |hash, (field,index)|
        hash.merge index.to_s => {
        property_name: field.titleize,
        value: saleable.decorate.send(field)
      }
    end

    # Hash of attributes passed to the Spree::Product when saved.
    def attributes
      {
        :name => name,
        :description => description,
        :meta_description => description,
        :available_on => created_at,
        :image => {
          attachment: image,
          alt: name,
          viewable: saleable
        },
        :price => price,
        :shipping_category => default_shipping_category,
        :metadata => metadata
      }
    end
  end
end

require 'rails_helper'
require 'wax_poetic/product'

module WaxPoetic
  RSpec.describe Product, :type => :lib do
    class SaleableRecord
      include ActiveModel::Model
      attr_accessor :name, :description, :created_at, :image_filepath, :price

      def decorate
        SaleableRecordDecorator.decorate self
      end
    end

    class SaleableRecordDecorator < Draper::Decorator
      delegate_all

      def catalog_number
        'WXP-007'
      end

      def release_date
        Date.today
      end
    end

    let :saleable do
      SaleableRecord.new(
        name: 'test',
        description: 'moar test',
        created_at: Time.now,
        image_filepath: File.expand_path('./spec/fixtures/files/image.png'),
        price: 1.00
      )
    end

    subject { Product.new(saleable) }

    it "decorates the saleable record" do
      expect(subject.saleable.class.name).to eq(saleable.decorate.class.name)
    end

    it "uses the name of the saleable object" do
      expect(subject.name).to eq(saleable.name)
    end

    it "uses the description of the saleable object for multiple attrs" do
      expect(subject.description).to eq(saleable.description)
      expect(subject.meta_description).to eq(saleable.description)
    end

    it "sets available_on to the created_at date for instant availability by default" do
      expect(subject.available_on).to eq(saleable.created_at)
    end

    it "uses the image_filepath method to find the filepath of the image" do
      expect(subject.image.path).to eq(saleable.image_filepath)
    end

    it "uses the price of the saleable object" do
      expect(subject.price).to eq(saleable.price)
    end

    it "always sets the shipping category to default" do
      default_shipping_category = Spree::ShippingCategory.find_by_name 'Default'
      expect(subject.shipping_category).to eq(default_shipping_category)
    end

    it "builds a hash of metadata based on the metadata_field macros" do
      Product.metadata_field :catalog_number
      property_names = subject.metadata.map do |key, hash|
        hash[:property_name]
      end

      expect(Product.metadata_fields).to include(:catalog_number)
      expect(property_names).to include('Catalog Number')
    end

    it "finds the proper presenter for the given saleable" do
      release = releases :just_the_start
      presenter = Product.for(release)
      expect(presenter.class.name).to eq('ReleaseProduct')
    end
  end
end

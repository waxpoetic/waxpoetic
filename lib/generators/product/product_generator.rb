class ProductGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_presenter
    template 'presenter.rb.erb', "app/products/#{file_name}_product.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/products/#{file_name}_product_spec.rb"
  end
end

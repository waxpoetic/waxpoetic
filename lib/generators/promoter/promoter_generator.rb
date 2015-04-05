class PromoterGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_promoter
    template 'promoter.rb.erb', "app/promoters/#{file_name}_promoter.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/promoters/#{file_name}_promoter_spec.rb"
  end
end

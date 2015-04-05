class PatchGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_patch
    template 'patch.rb.erb', "app/patches/#{file_name}.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/patches/#{file_name}_spec.rb"
  end
end

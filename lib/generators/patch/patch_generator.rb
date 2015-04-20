class PatchGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_patch
    template 'patch.rb.erb', "app/patches/#{file_path}.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/patches/#{file_path}_spec.rb"
  end
end

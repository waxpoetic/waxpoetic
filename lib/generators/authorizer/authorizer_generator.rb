class AuthorizerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_authorizer
    template 'authorizer.rb.erb', "app/authorizers/#{file_name}_authorizer.rb"
  end

  def copy_test
    template 'spec.rb.erb', "spec/authorizers/#{file_name}_authorizer_spec.rb"
  end
end

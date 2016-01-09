begin
  require 'annotate'

  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults('position_in_routes'   => '',
                          'position_in_class'    => 'after',
                          'position_in_test'     => 'before',
                          'position_in_fixture'  => 'before',
                          'position_in_factory'  => 'before',
                          'show_indexes'         => 'true',
                          'simple_indexes'       => 'false',
                          'model_dir'            => 'app/models',
                          'include_version'      => 'false',
                          'require'              => '',
                          'exclude_tests'        => 'false',
                          'exclude_fixtures'     => 'true',
                          'exclude_factories'    => 'true',
                          'ignore_model_sub_dir' => 'false',
                          'skip_on_db_migrate'   => 'false',
                          'format_bare'          => 'true',
                          'format_rdoc'          => 'false',
                          'format_markdown'      => 'false',
                          'sort'                 => 'false',
                          'force'                => 'false',
                          'trace'                => 'false')
  end

  Annotate.load_tasks

  desc 'Annotate all models and routes'
  task annotations: [:annotate_models]
rescue LoadError; end

begin
  require 'yard'

  YARD::Rake::YardocTask.new :doc
rescue LoadError
end

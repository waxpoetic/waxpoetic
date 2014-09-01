module FixtureFiles
  # Read out a demo file.
  def files(name)
    File.read File.expand_path("./spec/fixtures/files/#{name}")
  end
end

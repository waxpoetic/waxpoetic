# Code to import legacy data from the classic database.
module Legacy
  def self.export!
    [Artist, Release].map(&:export!)
  end
end

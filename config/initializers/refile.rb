if defined? Refile::S3
  Refile.cache = Refile::S3.new(prefix: "cache", **WaxPoetic.secrets.aws)
  Refile.store = Refile::S3.new(prefix: "store", **WaxPoetic.secrets.aws)
  Refile.cdn_host = WaxPoetic.secrets.cdn_host
end

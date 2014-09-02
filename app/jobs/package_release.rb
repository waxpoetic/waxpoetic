# Package a release up with `tar` and upload it to the 
class PackageRelease < ActiveJob::Base
  def perform(release)
    track_sources = track_paths_for release.tracks
    package_destination = package_path_of release.name

    sh "tar -czf #{package_destination} #{track_sources}"
    release.package.upload! package_destination

    logger.info "Release '#{release.name}' has been packaged and uploaded."
  end

  private
  def track_paths_for(tracks)
    tracks.map { |track|
      track.file.cache_path
    }.join("\s")
  end

  def package_path_of(name)
    "#{Rails.root}/tmp/cache/package-#{Time.now.to_i}-#{name}.zip"
  end
end

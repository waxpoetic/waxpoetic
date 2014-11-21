# Package a release up with `tar` and upload it to the 
class PackageRelease < ActiveJob::Base
  attr_reader :release

  def perform(release)
    @release = release
    track_sources = track_paths_for release.tracks
    package_destination = package_path_of release.decorate.filename

    sh "tar -czf #{package_destination} #{track_sources}"
    release.file.store! package_destination

    logger.info "Release '#{release.name}' has been packaged and uploaded."
  end

  private
  def track_paths_for(tracks)
    tracks.map { |track|
      track.file.path
    }.join("\s")
  end

  def package_path_of(name)
    "#{Rails.root}/tmp/cache/package-#{Time.now.to_i}-#{name}.zip"
  end

  def sh(command)
    return true if Rails.env.test?
    `#{command}` && $?.success?
  end
end

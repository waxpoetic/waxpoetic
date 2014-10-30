
# Authenticates a single user to download a given file, keyed by the
# Spree::Product this User has purchased. We don't want to have to make
# IAM users for every user who registers on the site, so we give them
# temporary access credentials when they ask for it using Amazon's
# Security Token Service. The only real job of this class is to output a
# fully-qualified URL for the given asset that is accessible to the
# public for a short amount of time.

class DownloadFile
  include ActiveModel::Model

  attr_accessor :download, :product, :resource, :variant

  # A temporarily authenticated URL for this product's file resource.
  # Combines the temporary policy's query params with the resource's
  # file URL.
  def to_url
    [ resource.file.url, policy.params ].join '?'
  end

  # Display name of this download.
  def name
    resource.decorate.title
  end

  private
  def policy
    @policy ||= WaxPoetic::TemporaryPolicy.new \
      path: filepath, name: "download-#{download.id}"
  end

  def filepath
    resource.filepath
  end
end

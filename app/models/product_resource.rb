require 'aws/sts'

# Authenticates a single user to download a given file, keyed by the
# Spree::Product this User has purchased. We don't want to have to make
# IAM users for every user who registers on the site, so we give them
# temporary access credentials when they ask for it using Amazon's
# Simple Token Service.

class ProductResource
  attr_reader :download

  def initialize(from_resource, and_download)
    @resource = from_resource
    @download = and_download
  end

  # A temporarily authenticated URL for this product's file resource.
  def to_url
    [ filepath, credential_params ].join '?'
  end

  private
  def session_name
    "download-#{download.id}"
  end

  def filepath
    resource.file.path
  end

  def sts
    AWS::STS.new
  end

  def policy
    policy = AWS::STS::Policy.new
    policy.allow(
      :resources => ["s3:#{bucket}/uploads/#{filepath}"],
      :actions => :get
    )
    policy
  end

  def session
    sts.new_federated_session "download-#{download.id}", policy: policy
  end

  def credential_params
    session.credentials.map { |key, value|
      "#{key.to_s.classify}=#{value}"
    }.join('&')
  end

  def bucket
    WaxPoetic.config.s3_bucket
  end
end

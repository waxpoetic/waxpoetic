require 'aws/sts'

# Authenticates a single user to download a given file, keyed by the
# Spree::Product this User has purchased. We don't want to have to make
# IAM users for every user who registers on the site, so we give them
# temporary access credentials when they ask for it using Amazon's
# Security Token Service. The only real job of this class is to output a
# fully-qualified URL for the given asset that is accessible to the
# public for a short amount of time.

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

  def policy
    @policy ||= begin
      pol = AWS::STS::Policy.new
      pol.allow get_resource
      pol
    end
  end

  def session
    sts = AWS::STS.new
    sts.new_federated_session sid, policy: policy, duration: 1.hour
  end

  def credential_params
    session.credentials.map { |key, value|
      "#{key.to_s.classify}=#{value}"
    }.join('&')
  end

  def sid
    "download-#{download.id}"
  end

  def get_resource
    {
      :resources => ["s3:#{resource.filepath}"],
      :actions => :get
    }
  end
end

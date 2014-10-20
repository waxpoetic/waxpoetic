require 'aws/sts'

# Authenticates a single user to download a given file, keyed by the
# Spree::Product this User has purchased. We don't want to have to make
# IAM users for every user who registers on the site, so we give them
# temporary access credentials when they ask for it.

class Download
  include ActiveModel::Model

  attr_accessor :order

  validates :order, presence: true

  delegate :user, :to => :order
  delegate :products, :to => :order

  # Since the Spree::Product can't be easily tied back to a Release or
  # Track (blackbox code and all that), we use this method on Download
  # to retrieve what the actual filepath of the resource object is.
  def product_resources
    products.map { |product|
      Release.find_by_product_id(product.id) || Track.find_by_product_id(product.id)
    }.select { |result| result.present? }
  end

  def url_for(product_resource)
    "#{product_resource.file.path}?#{authenticate(product_resource)}"
  end

  private
  def authenticate(resource)
    session = sts.new_federated_session user.email, policy: policy_for(resource.file.path)
    session.credentials.map { |key, value|
      "#{key.to_s.classify}=#{value}"
    }.join('&')
  end

  # The temporary access code policy we will use to enable access to the
  # given resource.
  def policy_for(filepath)
    policy = AWS::STS::Policy.new
    policy.allow \
      :actions   => ["s3:files.waxpoeticrecords.com/uploads/#{filepath}"],
      :resources => :any
    policy
  end

  def sts
    @sts ||= AWS::STS.new
  end
end

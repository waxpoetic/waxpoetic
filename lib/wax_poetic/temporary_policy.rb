require 'aws/sts'
require 'active_support/all'
require 'active_model'

module WaxPoetic
  # Gives a user temporary access to a given S3 resource using the AWS
  # Security Token Service. It's used by the DownloadFile to provide
  # access to a given download resource.
  class TemporaryPolicy
    include ActiveModel::Model

    attr_accessor :path, :name

    # STS credentials formatted for URL query params.
    def params
      credentials.map { |key, value|
        "#{key.to_s.classify}=#{value}"
      }.join('&')
    end

    # Credentials given by STS.
    delegate :credentials, :to => :session

    private
    def session
      sts.new_federated_session name, options
    end

    def options
      { policy: policy, duration: 1.hour }
    end

    def policy
      @policy ||= begin
        pol = AWS::STS::Policy.new
        pol.allow get_resource
        pol
      end
    end

    def get_resource
      {
        resources: ["arn:aws:s3:::#{path}"],
        actions: ["s3:GetObject"]
      }
    end

    def sts
      @sts ||= AWS::STS.new
    end
  end
end

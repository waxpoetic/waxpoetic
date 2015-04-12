require 'active_model/model'
require 'net/http'
require 'uri'

module WaxPoetic
  # Uses CircleCI to trigger a deployment build of our cookbook, which
  # will in turn deploy this application via Chef to AWS.
  class Deployment
    include ActiveModel::Model

    PROJECT = 'waxpoetic/cookbook'
    BRANCH = 'master'

    attr_accessor :token

    validates :token, presence: true

    def self.create(token)
      deploy = new token: token
      deploy.save
      deploy
    end

    def save
      valid? && create
    end

    def persisted?
      true
    end

    private

    def create
      response = Net::HTTP.post_form url
      response.is_a? Net::HTTPSuccess
    end

    def url
      URI.join(
        'https://circleci.com/api/v1/project',
        PROJECT,
        'tree',
        BRANCH,
        "?circle-token=#{token}"
      )
    end
  end
end

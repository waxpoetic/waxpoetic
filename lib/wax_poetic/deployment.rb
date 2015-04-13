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
    validates :current_tag, presence: {
      message: 'You may not deploy from a branch.'
    }

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
      response = Net::HTTP.post_form url, build_parameters: {
        'APP_VERSION' => current_tag
      }
      response.is_a? Net::HTTPSuccess
    end

    def current_tag
      @current_tag ||= begin
        tag = `git name-rev --tags --name-only $(git rev-parse HEAD)`
        tag == 'undefined' ? nil : tag
      end
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

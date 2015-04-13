require 'active_model/model'
require 'net/http'
require 'uri'
require 'semverse'

module WaxPoetic
  # Uses CircleCI to trigger a deployment build of our cookbook, which
  # will in turn deploy this application via Chef to AWS.
  class Deployment
    include ActiveModel::Model

    # Project name of the cookbook on CircleCI
    PROJECT = 'waxpoetic/cookbook'

    # Branch of the cookbook we want to build.
    BRANCH = 'master'

    # The CircleCI token we are using to access the cookbook.
    attr_accessor :token

    # The environment we are deploying to.
    attr_accessor :environment

    validates :token, presence: true
    validates :environment, presence: true

    # Create a new deployment for this app and deploy it to AWS.
    #
    # @returns [Deployment]
    def self.create(token, environment = 'staging')
      deploy = new token: token, environment: environment
      deploy.save
      eploy
    end

    # Deploy the next version of this app to staging and/or production.
    #
    # @returns [Boolean]
    def save
      valid? && new_record? && deploy
    end

    def persisted?
      @success || false
    end

    # Return the next version of this app
    #
    # @returns [String]
    def current_version
      if environment == 'production'
        current_tag
      else
        current_branch
      end
    end

    private

    def deploy
      @success = Net::HTTP.post_form(url, build_parameters: {
        'APP_VERSION' => current_version
      }).is_a? Net::HTTPSuccess
    end

    def url
      URI.join(
        'https://circleci.com/api/v1/project',
        PROJECT, 'tree', BRANCH, "?circle-token=#{token}"
      )
    end

    def current_tag
      @tag ||= `git tag`.split("\n")
    end

    def current_branch
      @branch ||= `git branch`.split("\n").find { |branch|
        branch =~ /\A\*\s/
      }.try(:gsub, /\A\*\s/, '')
    end
  end
end

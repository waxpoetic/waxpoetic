module Twitter
  class Post
    include ActiveModel::Model

    attr_accessor :release

    validates :release, presence: true
    validate :character_limit

    delegate :artist, :name,    to: :release
    delegate :twitter_account,  to: :artist

    def self.create(release)
      new(release: release).tap(&:save)
    end

    def save
      valid? && create
    end

    def tweet
      "OUT NOW! #{name} by #{twitter_account} -- #{short_link} #{tags}"
    end

    def tags
      release.tracks.map { |track| '#' + track.genre }.join(' ')
    end

    def persisted?
      @response.present?
    end

    private

    def character_limit
      errors.add :text, 'is over 140 characters' unless tweet.length <= 140
    end

    def create
      @response = client.update tweet
    end

    def client
      @client ||= Twitter::REST::Client.new WaxPoetic.secrets.twitter
    end
  end
end

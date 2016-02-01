module Facebook
  # A post on Facebook on behalf of a given page.
  class Post < Model
    attr_accessor :release

    validates :release, presence: true

    def self.create(release)
      new(release: release).tap do |post|
        post.save
      end
    end
  end
end

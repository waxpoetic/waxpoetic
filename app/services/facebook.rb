require 'koala'

# Service objects for accessing data within the Facebook API, using
# +Koala+ as a backend.
module Facebook
  # Gateway to the Facebook graph provided by +Koala+. Uses the
  # pre-obtained access token stored in secrets to perform all requests.
  #
  # @return [Koala::Facebook::API]
  def self.graph
    @graph ||= Koala::Facebook::API.new access_token
  end

  # OAuth access token obtained by +rake facebook:token+ and stored in
  # the environment configuration.
  #
  # @return [String]
  def self.access_token
    @access_token ||= WaxPoetic.secrets.facebook_access_token
  end
end

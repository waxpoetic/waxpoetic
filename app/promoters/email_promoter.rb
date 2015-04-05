# Send promotional emails to every Subscriber.
class EmailPromoter < WaxPoetic::Promoter
  RELEASE_LIST_ID = 12345

  def promote!(release, options={})
    mailchimp.campaigns.create(
      type: 'regular',
      options: {
        list_id: RELEASE_LIST_ID,
        subject: "#{release.name} by #{release.artist.name} has just been released!",
        from_email: 'releases@waxpoeticrecords.com',
        from_name: 'Wax Poetic Records',
      }
    )
  end

  private

  def mailchimp
    @mailchimp ||= Gibbon::API.new
  end
end

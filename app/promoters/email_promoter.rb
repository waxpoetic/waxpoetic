# Send promotional emails to every Subscriber.
class EmailPromoter < WaxPoetic::Promoter
  def promote!(release, options={})
    mailchimp.campaigns.create(
      type: 'regular',
      options: {
        list_id: WaxPoetic.config.mailchimp.release_list_id,
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

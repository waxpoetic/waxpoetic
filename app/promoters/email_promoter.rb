# Send promotional emails to every Subscriber.
class EmailPromoter < WaxPoetic::Promoter
  def promote!(release, _options = {})
    mailchimp.campaigns.create(
      type: 'regular',
      options: {
        list_id: list,
        subject: "#{release} has just been released!",
        from_email: 'catalog@waxpoeticrecords.com',
        from_name: 'Wax Poetic Records'
      }
    )
  end

  private

  def mailchimp
    @mailchimp ||= Gibbon::API.new WaxPoetic.secrets.mailchimp_api_key
  end
end

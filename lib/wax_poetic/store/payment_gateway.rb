module WaxPoetic
  class PaymentGateway
    # Build the object.
    alias fetch new

    # All params for use as a Spree::PaymentMethod.
    def params
      return base_params unless WaxPoetic.live?
      base_params.merge stripe_params
    end

    # Title of the gateway.
    def name
      payment_gateway.split('::').last.titleize
    end

    # Class name of the Spree payment gateway.
    def type
      if WaxPoetic.live?
        "Spree::Gateway::StripeGateway"
      else
        "Spree::Gateway::BogusGateway"
      end
    end

    private
    def base_params
      {
        name: name,
        type: type,
        environment: Rails.env,
        active: true
      }
    end

    def stripe_params
      {
        gateway_stripe_gateway: {
          preferred_secret_key: WaxPoetic.secrets.stripe_secret_key,
          preferred_publishable_key: WaxPoetic.secrets.stripe_publishable_key,
          preferred_test_mode: (not Rails.env.production?)
        }
      }
    end
  end
end
